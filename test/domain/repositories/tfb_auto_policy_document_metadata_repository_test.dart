import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/domain/models/auto_policy_document_metadata_repository/tfb_auto_policy_document_metadata.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_auto_policy_document_metadata_repository.dart';

import '../../mocks/mock_in_memory_local_database.dart';

void main() {
  late MockInMemoryLocalDatabase<String> inMemoryMockDatabase;
  late TfbAutoPolicyDocumentMetadataRepository metadataRepository;

  setUp(() {
    inMemoryMockDatabase = MockInMemoryLocalDatabase<String>()..init<void>();
    metadataRepository =
        TfbAutoPolicyDocumentMetadataRepository(inMemoryMockDatabase);
  });

  test(
      'Reading a value from TfbAutoPolicyDocumentMetadataRepository when no value has been written will return null',
      () async {
    final result = await metadataRepository.read('EMPTY_ID');

    expect(result, isNull);
  });

  test(
      'TfbAutoPolicyDocumentMetadataRepository can read documents after saving them',
      () async {
    const documentId = 'my_id';

    await metadataRepository.save(
      TfbAutoPolicyDocumentMetadata(
        policyNumber: '12345',
        vehicleDisplayTitles: ['test'],
        expirationDate: DateTime.parse('2023-09-09'),
        documentPath: '/documentPath',
        id: documentId,
      ),
    );

    final result = await metadataRepository.read(documentId);

    expect(result?.id, documentId);
  });

  test(
      'TfbAutoPolicyDocumentMetadataRepository can read all documents after saving multiple documents',
      () async {
    const documentId = 'my_id';
    const secondDocumentId = 'another_id';

    await metadataRepository.save(
      TfbAutoPolicyDocumentMetadata(
        policyNumber: '12345',
        vehicleDisplayTitles: ['test'],
        expirationDate: DateTime.parse('2023-09-09'),
        documentPath: '/documentPath',
        id: documentId,
      ),
    );

    await metadataRepository.save(
      TfbAutoPolicyDocumentMetadata(
        policyNumber: '12345',
        vehicleDisplayTitles: ['test'],
        expirationDate: DateTime.parse('2023-09-09'),
        documentPath: '/documentPath',
        id: secondDocumentId,
      ),
    );

    final result = await metadataRepository.readAll();

    expect(result.length, 2);
    expect(result.map((e) => e?.id).contains(documentId), isTrue);
    expect(result.map((e) => e?.id).contains(secondDocumentId), isTrue);
  });

  test(
      'Deleting a document in TfbAutoPolicyDocumentMetadataRepository will remove it from storage and make it not accessible',
      () async {
    const documentId = 'my_id';

    await metadataRepository.save(
      TfbAutoPolicyDocumentMetadata(
        policyNumber: '12345',
        vehicleDisplayTitles: ['test'],
        expirationDate: DateTime.parse('2023-09-09'),
        documentPath: '/documentPath',
        id: documentId,
      ),
    );

    await metadataRepository.delete(documentId);

    final result = await metadataRepository.read(documentId);

    expect(result, isNull);
  });
}
