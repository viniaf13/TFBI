import 'dart:io' as io;
import 'package:cross_file/cross_file.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:txfb_insurance_flutter/device/camera/camera_file_storage.dart';
import 'package:txfb_insurance_flutter/domain/exceptions/save_image_exception.dart';
import 'package:txfb_insurance_flutter/shared/enum/file_upload_state.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  void mockSharedPreferencesValues(String fileName, String date) {
    SharedPreferences.setMockInitialValues(
      {
        'import_photo_log_storage_key':
            '{"logs":[{"dateTime":"$date","photoName":"$fileName","response":"RESPONSE_SUCCESSFUL","numberOfRetries":0}]}',
      },
    );
  }

  group('Testing the camera file storage system', () {
    late io.Directory tempDirectory;

    setUpAll(() async {
      // Create a temporary folder for images to be stored in
      tempDirectory = await io.Directory('temp_camera_tests').create();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        ..setMockMethodCallHandler(
            const MethodChannel('plugins.flutter.io/path_provider'),
            (methodCall) async {
          if (methodCall.method == 'getApplicationDocumentsDirectory') {
            return tempDirectory.path;
          }
          if (methodCall.method == 'getTemporaryDirectory') {
            return tempDirectory.path;
          }
          return null;
        })
        ..setMockMethodCallHandler(
          const MethodChannel('disk_space'),
          (methodCall) async {
            if (methodCall.method == 'getFreeDiskSpaceForPath') {
              return 101.0;
            }
            return null;
          },
        );
    });

    tearDownAll(() async {
      // Delete temporary folder and all files inside
      await tempDirectory.delete(recursive: true);
    });

    test(
      'Verify that saving an image to the documents directory functions properly',
      () async {
        const fileName = 'testeFile.jpg';
        // Function to create the file to test
        await io.File(fileName).writeAsString('...');
        final testFile = XFile(fileName);
        const claimId = 'test1';
        final dateNow = DateTime.now().toIso8601String();
        XFile? newFile;
        mockSharedPreferencesValues(fileName, dateNow);
        newFile = await CameraFileStorage.saveImageToDocumentsDirectory(
          testFile,
          claimId,
          PolicyType.homeowners,
        );
        expect(newFile?.path.contains(claimId), isTrue);
      },
    );

    test(
      'Verify that listing all images for a given claim returns a correct number of files',
      () async {
        const nFiles = 5;
        const claimId = 'test2';
        // Create files for claim
        for (int i = 0; i < nFiles; i++) {
          final fileName = '$claimId-$i-selected.jpg';
          await io.File.fromUri(
            Uri.file(
              '${tempDirectory.path}/$fileName',
              windows: io.Platform.isWindows,
            ),
          ).writeAsString('...');
        }
        // Create files for a different claim
        for (int i = 0; i < nFiles; i++) {
          final fileName = 'test2other-$i-selected.jpg';
          await io.File.fromUri(
            Uri.file(
              '${tempDirectory.path}/$fileName',
              windows: io.Platform.isWindows,
            ),
          ).writeAsString('...');
        }
        final savedFiles =
            await CameraFileStorage.getImageFilesForClaim(claimId);
        expect(savedFiles.length, nFiles);
      },
    );

    test(
      'Verify that we get a correct state from an xfile',
      () {
        final selectedFile = XFile('ABCDE-000-selected.txt');
        final completeFile = XFile('ABCDE-000-complete.txt');
        final errorFile = XFile('ABCDE-000-error.txt');
        final exceededNumberOfRetriesFile =
            XFile('ABCDE-000-exceededNumberOfRetries.txt');

        final selectedState = CameraFileStorage.getFileState(selectedFile);
        final completeState = CameraFileStorage.getFileState(completeFile);
        final errorState = CameraFileStorage.getFileState(errorFile);
        final exceededNumberOfRetriesState =
            CameraFileStorage.getFileState(exceededNumberOfRetriesFile);

        expect(FileUploadState.selected, selectedState);
        expect(FileUploadState.complete, completeState);
        expect(FileUploadState.error, errorState);
        expect(
          FileUploadState.exceededNumberOfRetries,
          exceededNumberOfRetriesState,
        );
      },
    );

    test('Verify if the exception InsufficientSpaceException is thrown',
        () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('disk_space'),
        (methodCall) async {
          if (methodCall.method == 'getFreeDiskSpaceForPath') {
            return 1.0;
          }
          return null;
        },
      );
      final fileName = '${tempDirectory.path}/test3.jpg';
      // Function to create the file to test
      await io.File(fileName).writeAsString('...');
      final testFile = XFile(fileName);
      const claimId = '0000';
      final dateNow = DateTime.now().toIso8601String();
      mockSharedPreferencesValues(fileName, dateNow);
      await expectLater(
        CameraFileStorage.saveImageToDocumentsDirectory(
          testFile,
          claimId,
          PolicyType.homeowners,
        ),
        throwsA(isA<InsufficientSpaceException>()),
      );
    });
    test(
      'Verify that we get an incorrect state from an improper xfile',
      () {
        final file = XFile('ABCDE-000-foobar.txt');
        final state = CameraFileStorage.getFileState(file);
        expect(FileUploadState.error, state);
      },
    );

    test(
      'If there are no files to delete, file is not deleted',
      () async {
        const fileName = 'test4.jpg';
        final file = await io.File.fromUri(
          Uri.file(
            '${tempDirectory.path}/$fileName',
            windows: io.Platform.isWindows,
          ),
        ).writeAsString('...');
        final dateNow = DateTime.now().toIso8601String();
        mockSharedPreferencesValues(fileName, dateNow);
        expect(await file.exists(), isTrue);
        await CameraFileStorage.deleteExpiredPhotos();
        final shared = await SharedPreferences.getInstance();
        final photos = shared.getString('import_photo_log_storage_key');
        expect(photos?.contains(fileName), isTrue);
        expect(await file.exists(), isTrue);
      },
    );

    test(
      'If there are files to delete, file is deleted',
      () async {
        const fileName = 'test5.jpg';
        final dateFiveYearsAgo = DateTime.now()
            .subtract(const Duration(days: 1830))
            .toIso8601String();
        final file = await io.File.fromUri(
          Uri.file(
            '${tempDirectory.path}/$fileName',
            windows: io.Platform.isWindows,
          ),
        ).writeAsString('...');
        mockSharedPreferencesValues(fileName, dateFiveYearsAgo);
        expect(await file.exists(), isTrue);
        await CameraFileStorage.deleteExpiredPhotos();
        final shared = await SharedPreferences.getInstance();
        final photos = shared.getString('import_photo_log_storage_key');
        expect(photos?.contains(fileName), isFalse);
        expect(await file.exists(), isFalse);
      },
    );
  });
}
