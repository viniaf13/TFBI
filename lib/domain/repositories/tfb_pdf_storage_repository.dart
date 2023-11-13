import 'dart:convert';
import 'dart:typed_data';

import 'package:file/file.dart';
import 'package:txfb_insurance_flutter/data/network/clients/tfb_non_authenticate_client.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document_repository/tfb_pdf_document_delete.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document_repository/tfb_pdf_document_write.dart';

/// Repository for storing PDF document to the user's local device.
///
/// PDFs will be stored in the path returned from the [getRootDirectory] call
/// using the [fileSystem] object for storage.
class TfbPdfStorageRepository {
  TfbPdfStorageRepository({
    required this.fileSystem,
    required this.getRootDirectory,
    required this.getTempDirectory,
  });

  FileSystem fileSystem;
  Future<String> getRootDirectory;
  Future<String> getTempDirectory;

  /// Save the PDF to root directory
  ///
  /// Takes a [TfbPdfFileSave] object which includes the PDF base64
  /// string and the file name.
  Future<String> save(TfbPdfFileSave write, {bool isTemporary = false}) async {
    final filePath = await _createFileFromString(
      write.policyBase64,
      write.fileName,
      isTemporary,
    );

    return filePath;
  }

  /// Deletes a pdf from the root directory
  ///
  /// Takes a [TfbPdfFileDelete] which specifies the file path of
  /// the PDF to delete.
  Future<void> delete(TfbPdfFileDelete delete) async {
    final file = fileSystem.file(delete.fullFilePath);
    await file.delete();
  }

  /// Deletes all pdf from the temporary directory
  Future<void> deleteFromTemporary() async {
    final directory = fileSystem.directory(await _tempDirectory);

    directory.listSync().forEach((file) {
      file.deleteSync();
    });
  }

  String _createFullFilePath(
    String directory,
    String fileNameWithoutExtension,
  ) =>
      '$directory/$fileNameWithoutExtension.pdf';

  Future<File> _createDocumentFile(
    String fileName,
    bool isTemporary,
  ) async {
    String directory;
    if (isTemporary) {
      final tempPath = await _tempDirectory;
      await _createDirectoryIfNotExists(tempPath);

      directory = tempPath;
    } else {
      directory = await getRootDirectory;
    }

    return fileSystem.file(
      _createFullFilePath(
        directory,
        fileName,
      ),
    );
  }

  Future<String> _createFileFromString(
    String base64String,
    String fileName,
    bool isTemporary,
  ) async {
    final Uint8List bytes = base64.decode(base64String);
    final file = await _createDocumentFile(fileName, isTemporary);
    await file.writeAsBytes(bytes);
    return file.path;
  }

  Future<void> _createDirectoryIfNotExists(String pathDirectory) async {
    final tempDirectory = fileSystem.directory(pathDirectory);

    if (!(await tempDirectory.exists())) {
      await tempDirectory.create(recursive: true);
    }
  }

  Future<String> downloadPdfTemp(
    String documentUrl,
    String fileName,
  ) async {
    final filePath = '${await _tempDirectory}/$fileName.pdf';
    await TfbNonAuthenticateClient.instance.client.download(
      documentUrl,
      filePath,
    );
    return filePath;
  }

  Future<String> get _tempDirectory async => '${await getTempDirectory}/temp';
}
