import 'dart:io';
import 'package:cross_file/cross_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:txfb_insurance_flutter/shared/enum/file_upload_state.dart';

// This class trusts that the states are correct and that renaming will only
// be performed by a client that is transitioning a file between states. All
// files will ignore their current directory and be placed in the documents
// directory.
class CameraFileRenamer {
  static const preferencesKey = 'camera_file_number';

  /// This generates a new file number each time, and it does not matter!
  /// The only reason we use this number is to sequence the images, and in
  /// the unusual chance where things might get out of sequence, it will
  /// only have an extremely small impact on the user experience (the images
  /// might be out of order in the gallery)
  static Future<String> _nextFileNumber() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final current = sharedPreferences.getInt(preferencesKey) ?? 0;
    final next = current + 1;
    await sharedPreferences.setInt(preferencesKey, next);
    return '$next';
  }

  /// rename a file to reflect its new state
  static Future<XFile> renameFile(
    XFile xFile,
    FileUploadState state,
    String claimType,
    String claimId,
  ) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final fileExtension = xFile.path.split('.').last;
    final splittedPath = xFile.path.split('-');
    final newFileName = state == FileUploadState.selected
        ? await _nextFileNumber()
        : splittedPath[splittedPath.length - 2];
    final fileType = state.name;
    final fileNamePath =
        '${directory.path}/$claimId-$claimType-$newFileName-$fileType.$fileExtension';
    final bool fileExists = await File(xFile.path).exists();
    if (fileExists) {
      File(xFile.path).rename(fileNamePath);
    } else {
      await xFile.saveTo(fileNamePath);
    }
    return XFile(fileNamePath);
  }
}
