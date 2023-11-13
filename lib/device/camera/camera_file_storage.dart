import 'dart:io';
import 'package:cross_file/cross_file.dart';
import 'package:disk_space/disk_space.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:txfb_insurance_flutter/data/storage/import_photo_log_store.dart';
import 'package:txfb_insurance_flutter/domain/exceptions/save_image_exception.dart';
import 'package:txfb_insurance_flutter/shared/enum/file_upload_state.dart';
import 'package:txfb_insurance_flutter/device/camera/camera_file_renamer.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class CameraFileStorage {
  /// saves an image to the documents directory, naming it according to the
  /// state (which will always be _selected_ using this function)
  static Future<XFile?> saveImageToDocumentsDirectory(
    XFile? image,
    String claimId,
    PolicyType claimType,
  ) async {
    if (await checkIfDiscSpaceIsAvailable(1)) {
      return _saveImageToDocumentsDirectory(
        image,
        claimId,
        claimType,
      );
    } else {
      throw InsufficientSpaceException(message: 'No space available');
    }
  }

  static Future<List<XFile?>> saveImagesToDocumentsDirectoryBulk(
    List<XFile?> images,
    String claimId,
    PolicyType claimType,
  ) async {
    final List<XFile?> responses = [];
    if (await checkIfDiscSpaceIsAvailable(images.length)) {
      for (final image in images) {
        final response = await _saveImageToDocumentsDirectory(
          image,
          claimId,
          claimType,
        );
        responses.add(response);
      }
      return responses;
    }
    throw InsufficientSpaceException(message: 'No space available');
  }

  static Future<XFile?> _saveImageToDocumentsDirectory(
    XFile? image,
    String claimId,
    PolicyType claimType,
  ) async {
    if (image == null) return null;
    final newImage = await resizeImageFile(image);
    return CameraFileRenamer.renameFile(
      newImage,
      FileUploadState.selected,
      claimType.value,
      claimId,
    );
  }

  /// returns all files for a claim with the provided claim ID
  static Future<List<XFile>> getImageFilesForClaim(String claimId) async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final files = documentsDirectory.listSync();
    final claimFiles = <XFile>[];
    for (final file in files) {
      if (file.uri.pathSegments.last.split('-').first == claimId) {
        claimFiles.add(XFile(file.path));
      }
    }
    return claimFiles;
  }

  /// returns all files that have not been uploaded
  static Future<List<XFile>> getUnsubmittedImageFiles() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final files = documentsDirectory.listSync();
    final unsubmittedFiles = <XFile>[];
    for (final file in files) {
      final fileName = file.uri.pathSegments.last;
      final fileNameWithoutExtension = fileName.split('.').first;
      final fileStatus = fileNameWithoutExtension.split('-').last;
      if (fileStatus == FileUploadState.selected.name) {
        unsubmittedFiles.add(XFile(file.path));
      }
    }
    return unsubmittedFiles;
  }

  /// returns an image from an XFile. Just a simple helper function!
  static Future<Image?> imageFromXFile(XFile file) async {
    final bytes = await file.readAsBytes();
    return Image.memory(bytes);
  }

  /// provides the state of a given file, which will be error if there is
  /// no state in the file name
  static FileUploadState getFileState(XFile file) {
    for (final state in FileUploadState.values) {
      if (file.path.contains(state.name)) return state;
    }
    return FileUploadState.error;
  }

  /// checks that there is enough storage available for the file(s)
  /// (this is not a perfect check, but it is good enough for our purposes)
  /// The package used returns available space in MB. This information is not present in documentation but can be verified at
  /// https://github.com/mboeddeker/disk_space/blob/master/android/src/main/kotlin/de/appgewaltig/disk_space/MethodHandlerImpl.kt
  /// This can be tested in iOS with https://github.com/Kirchberg/FillStorage
  /// Returns the message to display if there is not enough space, or null
  /// if there is enough space.
  /// At the point where this is called, use context.getLocalizationOf.photosInsufficientSpace
  /// as the message.
  static Future<bool> checkIfDiscSpaceIsAvailable(int numberOfPictures) async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final spaceInMegabytes =
        await DiskSpace.getFreeDiskSpaceForPath(documentsDirectory.path);
    final double requiredDiskSpace = numberOfPictures * 10; // 10 MB
    return (spaceInMegabytes ?? 0) > requiredDiskSpace;
  }

  /// Resizes an image file to a smaller size if it is larger than 10MB.
  /// Creates a _new_ file in the temporary directory as a replacement.
  static Future<XFile> resizeImageFile(XFile file) async {
    final temporaryDirectory = await getTemporaryDirectory();
    final bytes = await file.readAsBytes();
    const maxSize = 10 * 1024 * 1024;
    // Early out on small files, so that we do the check _here_ and not at
    // the point where this would be called.
    if (bytes.length <= maxSize) {
      return file;
    }
    // We have a big file. Let's resize this. First, create an image.
    final image = await img.decodeImageFile(file.path);
    if (image == null) {
      return file;
    }

    final originalHeight = image.height;
    final computedHeight = originalHeight * 0.5;
    final resized = img.copyResize(image, height: computedHeight.toInt());
    final jpg = img.encodeJpg(resized, quality: 80);

    // Create a new file in the temporary directory
    final newFile =
        XFile.fromData(jpg, path: '${temporaryDirectory.path}/temp.jpg')
          ..saveTo('${temporaryDirectory.path}/temp.jpg');
    return newFile;
  }

  static Future<void> deleteExpiredPhotos() async {
    final logStore = ImportPhotoLogStore(
      prefs: await ImportPhotoLogStore.getDefaultSharedPrefs(),
    );
    await logStore.prefs.reload();
    final expiredPhotos = logStore.getExpiredPhotos();
    if (expiredPhotos.isEmpty) return;

    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final files = documentsDirectory.listSync();
    for (final file in expiredPhotos) {
      try {
        final deleteFile = files.firstWhere(
          (element) => element.path.contains(file.photoName),
        );
        await deleteFile.delete();
      } catch (ex) {
        continue;
      }
    }
    logStore.photoLog.logs.removeWhere(expiredPhotos.contains);
    await logStore.update();
  }
}
