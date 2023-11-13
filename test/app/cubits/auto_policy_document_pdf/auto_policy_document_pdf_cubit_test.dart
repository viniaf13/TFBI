import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/auto_policy_document_pdf/auto_policy_document_pdf_cubit.dart';
import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/models/models.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document/pdf_document_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document/pdf_document_page.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document_repository/tfb_pdf_document_write.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_document_request.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_list_metadata.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_document_information_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_pdf_storage_repository.dart';

import '../../../mocks/mock_policy_lookup_client.dart';
import '../../../mocks/mock_tfb_document_information_client.dart';
import '../../../mocks/mock_tfb_pdf_storage_repository.dart';

void main() {
  late TfbDocumentInformationClient mockDocumentInformationClient;
  late TfbPdfStorageRepository mockPdfStoreRepository;

  final testPolicySummary = MockPolicy.createPolicySummary();
  final testPolicyDetail = MockPolicy.createAutoPolicyDetail();
  final testPolicyListMetadata = PolicyListMetadata(
    date: '20-07-2018',
    documentId: '123',
    formDescription: '2',
    labelDescription: 'document',
    pageNumber: 0,
    versionId: '1',
  );
  final testSaveDocumentFile = TfbPdfFileSave(policyBase64: '', fileName: '');

  setUp(() {
    mockDocumentInformationClient = MockTfbDocumentInformationClient();
    mockPdfStoreRepository = MockTfbPdfStorageRepository();

    registerFallbackValue(testPolicySummary);
    registerFallbackValue(testPolicyDetail);
    registerFallbackValue(testSaveDocumentFile);

    registerFallbackValue(
      PolicyDocumentRequest(
        policyNumber: '123',
        policySubtype: '123',
        policyType: PolicyType.txPersonalAuto,
        documentId: '123',
      ),
    );
  });

  test(
      '[AutoPolicyDocumentPdfCubit] should start in the [AutoPolicyDocumentPdfInitial] state',
      () {
    expect(
      AutoPolicyDocumentPdfCubit(
        documentInformationRepository: TfbDocumentInformationRepository(
          client: mockDocumentInformationClient,
        ),
        documentPdfRepository: mockPdfStoreRepository,
      ).state,
      isA<AutoPolicyDocumentPdfInitial>(),
    );
  });

  blocTest<AutoPolicyDocumentPdfCubit, AutoPolicyDocumentPdfState>(
    'If the document client [getPolicyDocumentMetadata] call fails, move to a [AutoPolicyDocumentPdfError] state',
    build: () => AutoPolicyDocumentPdfCubit(
      documentInformationRepository: TfbDocumentInformationRepository(
        client: mockDocumentInformationClient,
      ),
      documentPdfRepository: mockPdfStoreRepository,
    ),
    setUp: () {
      when(
        () => mockDocumentInformationClient.getPolicyDocumentMetadata(
          any(),
          any(),
        ),
      ).thenThrow(Exception('ERROR'));
    },
    act: (bloc) => bloc.getPolicyDocumentMetadata(
      testPolicySummary,
      testPolicyListMetadata,
    ),
    expect: () => [
      isA<AutoPolicyDocumentPdfProcessing>(),
      isA<AutoPolicyDocumentPdfError>(),
    ],
  );

  blocTest<AutoPolicyDocumentPdfCubit, AutoPolicyDocumentPdfState>(
    'If the document client [getPolicyDocumentMetadata] call succeeds, move to a [AutoPolicyDocumentPdfSuccess] state',
    build: () => AutoPolicyDocumentPdfCubit(
      documentInformationRepository: TfbDocumentInformationRepository(
        client: mockDocumentInformationClient,
      ),
      documentPdfRepository: mockPdfStoreRepository,
    ),
    setUp: () {
      when(
        () => mockPdfStoreRepository.save(
          any(),
          isTemporary: true,
        ),
      ).thenAnswer(
        (invocation) => Future.value('filename'),
      );
      when(
        () => mockDocumentInformationClient.getPolicyDocumentMetadata(
          any(),
          any(),
        ),
      ).thenAnswer(
        (invocation) => Future.value(
          PdfDocumentMetadata(
            mimeType: '',
            pages: [PdfDocumentPage(content: '')],
            rotation: 0,
            scale: 1,
            supportedMimeTypes: ['pdf'],
            width: 0,
          ),
        ),
      );
    },
    act: (bloc) => bloc.getPolicyDocumentMetadata(
      testPolicySummary,
      testPolicyListMetadata,
    ),
    expect: () => [
      isA<AutoPolicyDocumentPdfProcessing>(),
      isA<AutoPolicyDocumentPdfSuccess>(),
    ],
  );

  blocTest<AutoPolicyDocumentPdfCubit, AutoPolicyDocumentPdfState>(
    'If the document client [getPolicyDocumentMetadata] call succeeds, move to a [AutoPolicyDocumentPdfSuccess] state',
    build: () => AutoPolicyDocumentPdfCubit(
      documentInformationRepository: TfbDocumentInformationRepository(
        client: mockDocumentInformationClient,
      ),
      documentPdfRepository: mockPdfStoreRepository,
    ),
    setUp: () {
      when(() => mockPdfStoreRepository.deleteFromTemporary()).thenAnswer(
        (invocation) => Future.value(),
      );
      when(
        () => mockPdfStoreRepository.save(
          any(),
          isTemporary: true,
        ),
      ).thenAnswer(
        (invocation) => Future.value('filename'),
      );
    },
    act: (bloc) => bloc.deletePolicyDocumentsFromTemporary(),
  );
}
