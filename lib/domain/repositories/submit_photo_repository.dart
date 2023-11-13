import 'package:cross_file/cross_file.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:txfb_insurance_flutter/data/storage/import_photo_log_store.dart';
import 'package:txfb_insurance_flutter/device/camera/camera_file_renamer.dart';
import 'package:txfb_insurance_flutter/device/camera/camera_file_storage.dart';
import 'package:txfb_insurance_flutter/domain/clients/file_a_claim_client.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/photo_log.dart';
import 'package:txfb_insurance_flutter/shared/enum/file_upload_state.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

const kmaxNumberOfRetries = 3;

class SubmitPhotoRepository {
  Future<bool> importPhoto() async {
    const secureStorage = FlutterSecureStorage();
    final baseUrl = await secureStorage.read(key: kApiBaseUrl);
    final accessToken = await secureStorage.read(key: kTfbUserToken);

    // Stops workmanager if user or API info is missing
    if (baseUrl == null || accessToken == null) {
      return false;
    }

    final List<XFile> photos =
        await CameraFileStorage.getUnsubmittedImageFiles();

    for (final photo in photos) {
      final logStore = ImportPhotoLogStore(
        prefs: await ImportPhotoLogStore.getDefaultSharedPrefs(),
      );

      XFile file = XFile(photo.path);

      if (photo.name.contains(FileUploadState.error.name) ||
          photo.name.contains(FileUploadState.selected.name)) {
        final FormData data = FormData.fromMap(
          {
            'file': MultipartFile.fromBytes(
              await file.readAsBytes(),
              filename: photo.name,
            ),
          },
        );

        int numberOfRetries = 0;
        // photos are named in this format: claimId-claimType-uniqueIdentifier-status
        final photoNameSplit = photo.name.split('-');
        final claimId = photoNameSplit.first;
        final claimType = photoNameSplit[1];

        try {
          if (photo.name.contains(FileUploadState.error.name)) {
            numberOfRetries = logStore.getNumberOfRetriesByFileName(photo.name);
          }
          await _submitPhoto(
            data,
            claimId,
            claimType,
            accessToken,
            baseUrl,
          );

          file = await CameraFileRenamer.renameFile(
            photo,
            FileUploadState.complete,
            claimType,
            claimId,
          );

          _registerLog(
            file.name,
            kResponseSuccessful,
            numberOfRetries,
            logStore,
          );
        } catch (e) {
          numberOfRetries++;

          final newState = numberOfRetries > kmaxNumberOfRetries
              ? FileUploadState.exceededNumberOfRetries
              : FileUploadState.error;

          file = await CameraFileRenamer.renameFile(
            photo,
            newState,
            claimType,
            claimId,
          );

          _registerLog(
            file.name,
            e.toString(),
            numberOfRetries,
            logStore,
          );

          return false;
        }
      }
    }
    return true;
  }

  Future<void> _submitPhoto(
    FormData data,
    String claimId,
    String policyType,
    String userAcessToken,
    String baseUrl,
  ) async {
    final authenticatedDio = Dio(
      BaseOptions(
        headers: {'Authorization': 'Bearer $userAcessToken'},
      ),
    );

    HavenProxyService.addProxyIfSet(authenticatedDio);

    final client = FileAClaimClient(
      baseUrl: baseUrl,
      dio: authenticatedDio,
    );

    if (policyType == PolicyType.homeowners.value) {
      await client.submitPhotoForPropertyClaim(data, claimId);
    } else if (policyType == PolicyType.txPersonalAuto.value) {
      await client.submitPhotoForAutoClaim(data, claimId);
    }
  }

  Future<void> _registerLog(
    String photoName,
    String response,
    int numberOfRetries,
    ImportPhotoLogStore logStore,
  ) async {
    final PhotoRegister log = PhotoRegister(
      dateTime: DateTime.now().toString(),
      photoName: photoName,
      response: response,
      numberOfRetries: numberOfRetries,
    );

    await logStore.store(register: log);
  }
}
