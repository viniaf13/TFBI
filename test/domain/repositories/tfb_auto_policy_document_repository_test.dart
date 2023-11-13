import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document_repository/tfb_pdf_document_delete.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document_repository/tfb_pdf_document_write.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_pdf_storage_repository.dart';

void main() {
  const testRootDirectory = '/testDirectory';
  const testTempDirectory = '/testTempDirectory';
  late FileSystem fileSystem;

  setUp(() {
    fileSystem = MemoryFileSystem();
    fileSystem.directory(testRootDirectory).create();
  });

  test(
      'Saving an auto policy document should make it available in the file system.',
      () async {
    const fileName = 'test';
    const fullFilePathWithExtension = '$testRootDirectory/$fileName.pdf';

    final documentRepository = TfbPdfStorageRepository(
      getTempDirectory: Future.value(testTempDirectory),
      getRootDirectory: Future.value(testRootDirectory),
      fileSystem: fileSystem,
    );

    await documentRepository.save(
      TfbPdfFileSave(
        policyBase64: 'policyBase64',
        fileName: fileName,
      ),
    );

    expect(await fileSystem.isFile(fullFilePathWithExtension), isTrue);
  });

  test(
      'Deleting an auto policy document after it has been saved should remove it from the file system',
      () async {
    const fileName = 'test';
    const fullFilePathWithExtension = '$testRootDirectory/$fileName.pdf';

    final documentRepository = TfbPdfStorageRepository(
      getTempDirectory: Future.value(testTempDirectory),
      getRootDirectory: Future.value(testRootDirectory),
      fileSystem: fileSystem,
    );

    await documentRepository.save(
      TfbPdfFileSave(
        policyBase64: 'policyBase64',
        fileName: fileName,
      ),
    );

    await documentRepository.delete(
      TfbPdfFileDelete(fullFilePath: fullFilePathWithExtension),
    );

    expect(await fileSystem.isFile(fullFilePathWithExtension), isFalse);
  });
}
