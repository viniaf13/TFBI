import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing_document_pdf/billing_document_pdf_cubit.dart';
import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/billing_document_version_request.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/billing_list_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document/pdf_document_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document/pdf_document_page.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document_repository/tfb_pdf_document_write.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_pdf_storage_repository.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

import '../../../mocks/mock_tfb_pdf_storage_repository.dart';
import '../../../mocks/mock_tfb_document_information_client.dart';
import '../auto_policy/auto_policy_cubit_test.dart';

void main() {
  final TfbDocumentInformationClient mockDocumentInformationClient =
      MockTfbDocumentInformationClient();
  final TfbPdfStorageRepository mockPolicyDocumentRepository =
      MockTfbPdfStorageRepository();

  setUp(() {
    registerFallbackValue(testPolicySummary);
    registerFallbackValue(
      _testBillingListMetadata,
    );
    registerFallbackValue(TfbPdfFileSave(fileName: '', policyBase64: ''));
    registerFallbackValue(
      BillingDocumentVersionRequest(
        policyNumber: 'policyNumber',
        policyType: 'policyType',
        policySubType: 1,
        versionId: 'versionId',
        descriptionTerm: 'descriptionTerm',
      ),
    );
  });

  blocTest<BillingDocumentPdfCubit, BillingDocumentPdfState>(
    'When getBillingDocument fails because the getBillingDocumentByVersion fails, the cubit should move to the error state',
    setUp: () {
      when(
        () => mockDocumentInformationClient.getBillingDocumentByVersion(
          any(),
          any(),
        ),
      ).thenThrow(DioException(requestOptions: RequestOptions()));
    },
    build: () => BillingDocumentPdfCubit(
      client: mockDocumentInformationClient,
      documentPdfRepository: mockPolicyDocumentRepository,
    ),
    act: (bloc) =>
        bloc.getBillingDocument(testPolicySummary, _testBillingListMetadata),
    expect: () =>
        [isA<BillingDocumentPdfProcessing>(), isA<BillingDocumentPdfError>()],
  );

  blocTest<BillingDocumentPdfCubit, BillingDocumentPdfState>(
    'When getBillingDocument passes the getBillingDocumentByVersion step but has more than one page, the cubit should move to the error state',
    setUp: () {
      when(
        () => mockDocumentInformationClient.getBillingDocumentByVersion(
          any(),
          any(),
        ),
      ).thenAnswer(
        (invocation) async => _multiPagePdfResponse,
      );
    },
    build: () => BillingDocumentPdfCubit(
      client: mockDocumentInformationClient,
      documentPdfRepository: mockPolicyDocumentRepository,
    ),
    act: (bloc) =>
        bloc.getBillingDocument(testPolicySummary, _testBillingListMetadata),
    expect: () =>
        [isA<BillingDocumentPdfProcessing>(), isA<BillingDocumentPdfError>()],
  );

  blocTest<BillingDocumentPdfCubit, BillingDocumentPdfState>(
    'When getBillingDocument passes the getBillingDocumentByVersion but has zero pages, the cubit should move to the error state',
    setUp: () {
      when(
        () => mockDocumentInformationClient.getBillingDocumentByVersion(
          any(),
          any(),
        ),
      ).thenAnswer((invocation) async => _emptyPdfResponse);
    },
    build: () => BillingDocumentPdfCubit(
      client: mockDocumentInformationClient,
      documentPdfRepository: mockPolicyDocumentRepository,
    ),
    act: (bloc) =>
        bloc.getBillingDocument(testPolicySummary, _testBillingListMetadata),
    expect: () =>
        [isA<BillingDocumentPdfProcessing>(), isA<BillingDocumentPdfError>()],
  );

  blocTest<BillingDocumentPdfCubit, BillingDocumentPdfState>(
    'When getBillingDocument passes the getBillingDocumentByVersion but fails the PDF save step, the cubit should move to the error state',
    setUp: () {
      when(
        () => mockDocumentInformationClient.getBillingDocumentByVersion(
          any(),
          any(),
        ),
      ).thenAnswer((invocation) async => _singlePagePdfResponse);

      when(() => mockPolicyDocumentRepository.save(any()))
          .thenThrow(Exception('Failed to save'));
    },
    build: () => BillingDocumentPdfCubit(
      client: mockDocumentInformationClient,
      documentPdfRepository: mockPolicyDocumentRepository,
    ),
    act: (bloc) =>
        bloc.getBillingDocument(testPolicySummary, _testBillingListMetadata),
    expect: () =>
        [isA<BillingDocumentPdfProcessing>(), isA<BillingDocumentPdfError>()],
  );

  blocTest<BillingDocumentPdfCubit, BillingDocumentPdfState>(
    'When getBillingDocument passes the getBillingDocumentByVersion and the PDF save, move to the success state',
    setUp: () {
      when(
        () => mockDocumentInformationClient.getBillingDocumentByVersion(
          any(),
          any(),
        ),
      ).thenAnswer((invocation) async => _singlePagePdfResponse);

      when(() => mockPolicyDocumentRepository.save(any()))
          .thenAnswer((invocation) async => 'filePath');
    },
    build: () => BillingDocumentPdfCubit(
      client: mockDocumentInformationClient,
      documentPdfRepository: mockPolicyDocumentRepository,
    ),
    act: (bloc) =>
        bloc.getBillingDocument(testPolicySummary, _testBillingListMetadata),
    expect: () =>
        [isA<BillingDocumentPdfProcessing>(), isA<BillingDocumentPdfSuccess>()],
  );
}

final _testBillingListMetadata = BillingListMetadata(
  date: 'date',
  documentId: 'documentId',
  formDescription: 'formDescription',
  labelDescription: 'labelDescription',
  pageNumber: 1,
  versionId: 'versionId',
);

final _emptyPdfResponse = PdfDocumentMetadata(
  mimeType: 'mimeType',
  pages: [],
  rotation: 0,
  scale: 1,
  supportedMimeTypes: [],
  width: 1,
);

final _multiPagePdfResponse = PdfDocumentMetadata(
  mimeType: 'mimeType',
  pages: [
    PdfDocumentPage(content: 'content'),
    PdfDocumentPage(content: 'content'),
  ],
  rotation: 0,
  scale: 1,
  supportedMimeTypes: [],
  width: 1,
);

final _singlePagePdfResponse = PdfDocumentMetadata(
  mimeType: 'mimeType',
  pages: [PdfDocumentPage(content: 'content')],
  rotation: 0,
  scale: 1,
  supportedMimeTypes: [],
  width: 1,
);
