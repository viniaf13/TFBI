import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/photo_log.dart';

const importPhotoLogStorageKey = 'import_photo_log_storage_key';
const maxPhotoRetentionTimeInYears = 5;

class ImportPhotoLogStore {
  ImportPhotoLogStore({
    required this.prefs,
  });

  SharedPreferences prefs;
  PhotoLog photoLog = PhotoLog(
    logs: [],
  );

  static Future<SharedPreferences> getDefaultSharedPrefs() =>
      SharedPreferences.getInstance();

  void getLogs() {
    final String? stringLogs = prefs.getString(importPhotoLogStorageKey);
    if (stringLogs != null) {
      final Map<String, dynamic> logsDecoded =
          json.decode(stringLogs) as Map<String, dynamic>;
      photoLog = PhotoLog.fromJson(logsDecoded);
    }
  }

  Future<void> store({
    required PhotoRegister register,
  }) async {
    getLogs();
    if (photoLog.logs.isEmpty) {
      photoLog.logs.add(register);
    } else {
      final existedRegister = photoLog.logs
          .where((e) => e.photoName == register.photoName)
          .firstOrNull;
      if (existedRegister != null) {
        existedRegister
          ..dateTime = register.dateTime
          ..photoName = register.photoName
          ..response = register.response
          ..numberOfRetries = register.numberOfRetries;
      } else {
        photoLog.logs.add(register);
      }
    }

    final String photoRegisterToJson = json.encode(photoLog.toJson());
    await prefs.setString(importPhotoLogStorageKey, photoRegisterToJson);
  }

  Future<void> clear() async {
    await prefs.setString(importPhotoLogStorageKey, '');
  }

  Future<void> update() async {
    final String photoRegisterToJson = json.encode(photoLog.toJson());
    await prefs.setString(importPhotoLogStorageKey, photoRegisterToJson);
  }

  int getNumberOfRetriesByFileName(String name) {
    getLogs();
    if (photoLog.logs.isNotEmpty) {
      final register =
          photoLog.logs.where((e) => e.photoName == name).firstOrNull;
      return register == null ? 0 : register.numberOfRetries;
    }
    return 0;
  }

  List<PhotoRegister> getExpiredPhotos() {
    if (photoLog.logs.isEmpty) getLogs();
    return photoLog.logs.where(
      (element) {
        final datePhoto = DateTime.parse(element.dateTime);
        final distanceToNow = datePhoto.difference(DateTime.now()).inDays.abs();
        final isMoreThen5Years =
            (distanceToNow / 365) >= maxPhotoRetentionTimeInYears;
        return isMoreThen5Years;
      },
    ).toList();
  }
}
