import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/save_auto_id_card/save_auto_id_card_cubit.dart';
import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/models/auto_policy_document_metadata_repository/tfb_auto_policy_document_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document/pdf_document_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document/pdf_document_page.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document_repository/tfb_pdf_document_delete.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document_repository/tfb_pdf_document_write.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_auto_policy_document_metadata_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_document_information_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_pdf_storage_repository.dart';

import '../../../mocks/mock_tfb_auto_policy_document_metadata_repository.dart';
import '../../../mocks/mock_tfb_document_information_client.dart';
import '../../../mocks/mock_tfb_pdf_storage_repository.dart';
import '../auto_policy/auto_policy_cubit_test.dart';

void main() {
  late TfbPdfStorageRepository mockDocumentRepository;
  late TfbAutoPolicyDocumentMetadataRepository mockMetadataRepository;
  late TfbDocumentInformationClient mockDocumentClient;

  setUp(() {
    mockDocumentClient = MockTfbDocumentInformationClient();
    mockDocumentRepository = MockTfbPdfStorageRepository();
    mockMetadataRepository = MockTfbAutoPolicyDocumentMetadataRepository();

    registerFallbackValue(
      TfbPdfFileSave(
        policyBase64: 'policyBase64',
        fileName: 'fileName',
      ),
    );

    registerFallbackValue(
      TfbAutoPolicyDocumentMetadata(
        documentPath: '',
        expirationDate: DateTime.now(),
        id: '',
        policyNumber: '',
        vehicleDisplayTitles: [],
      ),
    );

    registerFallbackValue(TfbPdfFileDelete(fullFilePath: ''));
  });

  test('Save auto id card cubit starts in initial state', () async {
    expect(
      SaveAutoIdCardCubit(
        documentRepository: mockDocumentRepository,
        documentInformationRepository: TfbDocumentInformationRepository(
          client: mockDocumentClient,
        ),
        metadataRepository: mockMetadataRepository,
      ).state,
      isA<SaveAutoIdCardInitial>(),
    );
  });

  blocTest<SaveAutoIdCardCubit, SaveAutoIdCardState>(
    'When saving the auto id card, if the PDF download fails, '
    'then move to the failed state',
    build: () => SaveAutoIdCardCubit(
      documentRepository: mockDocumentRepository,
      documentInformationRepository: TfbDocumentInformationRepository(
        client: mockDocumentClient,
      ),
      metadataRepository: mockMetadataRepository,
    ),
    setUp: () {
      when(
        () => mockDocumentClient.getAutoIdCardWithTypeAndDate(
          any(),
          any(),
          any(),
        ),
      ).thenThrow(Exception('ERROR'));
    },
    act: (bloc) => bloc.downloadAndSaveAutoIdCard(
      testPolicySummary,
      testPolicyDetail,
      isTemporary: false,
    ),
    expect: () =>
        [isA<SaveAutoIdCardProcessing>(), isA<SaveAutoIdCardFailure>()],
    verify: (bloc) {
      verify(
        () => mockDocumentClient.getAutoIdCardWithTypeAndDate(
          any(),
          any(),
          any(),
        ),
      ).called(1);

      verifyNever(() => mockDocumentRepository.save(any()));
    },
  );

  blocTest<SaveAutoIdCardCubit, SaveAutoIdCardState>(
    'When saving the auto id card, if the PDF download has zero pages, '
    'then move to the failed state',
    build: () => SaveAutoIdCardCubit(
      documentRepository: mockDocumentRepository,
      documentInformationRepository: TfbDocumentInformationRepository(
        client: mockDocumentClient,
      ),
      metadataRepository: mockMetadataRepository,
    ),
    setUp: () {
      when(
        () => mockDocumentClient.getAutoIdCardWithTypeAndDate(
          any(),
          any(),
          any(),
        ),
      ).thenAnswer(
        (invocation) => Future.value(
          PdfDocumentMetadata(
            mimeType: 'mimeType',
            pages: [],
            rotation: 0,
            scale: 0,
            supportedMimeTypes: [],
            width: 0,
          ),
        ),
      );
    },
    act: (bloc) => bloc.downloadAndSaveAutoIdCard(
      testPolicySummary,
      testPolicyDetail,
      isTemporary: true,
    ),
    expect: () =>
        [isA<SaveAutoIdCardProcessing>(), isA<SaveAutoIdCardFailure>()],
    verify: (bloc) {
      verify(
        () => mockDocumentClient.getAutoIdCardWithTypeAndDate(
          any(),
          any(),
          any(),
        ),
      ).called(1);

      verifyNever(() => mockDocumentRepository.save(any()));
    },
  );

  blocTest<SaveAutoIdCardCubit, SaveAutoIdCardState>(
    'When saving the auto id card, if the PDF is successfully downloaded '
    'but the call to save the PDF fails, move to the failed state',
    build: () => SaveAutoIdCardCubit(
      documentRepository: mockDocumentRepository,
      documentInformationRepository: TfbDocumentInformationRepository(
        client: mockDocumentClient,
      ),
      metadataRepository: mockMetadataRepository,
    ),
    setUp: () {
      when(
        () => mockDocumentClient.getAutoIdCardWithTypeAndDate(
          any(),
          any(),
          any(),
        ),
      ).thenAnswer(
        (invocation) => Future.value(
          PdfDocumentMetadata(
            mimeType: 'mimeType',
            pages: [PdfDocumentPage(content: '')],
            rotation: 0,
            scale: 0,
            supportedMimeTypes: [],
            width: 0,
          ),
        ),
      );

      when(() => mockDocumentRepository.save(any()))
          .thenThrow(Exception('FAILED TO SAVE PDF'));
    },
    act: (bloc) => bloc.downloadAndSaveAutoIdCard(
      testPolicySummary,
      testPolicyDetail,
      isTemporary: false,
    ),
    expect: () =>
        [isA<SaveAutoIdCardProcessing>(), isA<SaveAutoIdCardFailure>()],
    verify: (bloc) {
      verify(
        () => mockDocumentClient.getAutoIdCardWithTypeAndDate(
          any(),
          any(),
          any(),
        ),
      ).called(1);

      verify(() => mockDocumentRepository.save(any())).called(1);
      verifyNever(() => mockMetadataRepository.save(any()));
    },
  );

  blocTest<SaveAutoIdCardCubit, SaveAutoIdCardState>(
    'When saving the auto id card, if the PDF is successfully downloaded '
    'and the call to save the PDF are successful, but the metadata save '
    'fails, move to the failed state',
    build: () => SaveAutoIdCardCubit(
      documentRepository: mockDocumentRepository,
      documentInformationRepository: TfbDocumentInformationRepository(
        client: mockDocumentClient,
      ),
      metadataRepository: mockMetadataRepository,
    ),
    setUp: () {
      when(
        () => mockDocumentClient.getAutoIdCardWithTypeAndDate(
          any(),
          any(),
          any(),
        ),
      ).thenAnswer(
        (invocation) => Future.value(
          PdfDocumentMetadata(
            mimeType: 'mimeType',
            pages: [PdfDocumentPage(content: '')],
            rotation: 0,
            scale: 0,
            supportedMimeTypes: [],
            width: 0,
          ),
        ),
      );

      when(() => mockDocumentRepository.save(any())).thenAnswer(
        (invocation) => Future.value(''),
      );

      when(() => mockMetadataRepository.save(any()))
          .thenThrow(Exception('ERROR SAVING METADATA'));
    },
    act: (bloc) => bloc.downloadAndSaveAutoIdCard(
      testPolicySummary,
      testPolicyDetail,
      isTemporary: false,
    ),
    expect: () =>
        [isA<SaveAutoIdCardProcessing>(), isA<SaveAutoIdCardFailure>()],
    verify: (bloc) {
      verify(
        () => mockDocumentClient.getAutoIdCardWithTypeAndDate(
          any(),
          any(),
          any(),
        ),
      ).called(1);

      verify(() => mockDocumentRepository.save(any())).called(1);

      verify(() => mockMetadataRepository.save(any())).called(1);
    },
  );

  blocTest<SaveAutoIdCardCubit, SaveAutoIdCardState>(
    'When downloading the PDf, saving the PDF, and saving document metadata all succeed, move to the success saved state',
    build: () => SaveAutoIdCardCubit(
      documentRepository: mockDocumentRepository,
      documentInformationRepository: TfbDocumentInformationRepository(
        client: mockDocumentClient,
      ),
      metadataRepository: mockMetadataRepository,
    ),
    setUp: () {
      when(
        () => mockDocumentClient.getAutoIdCardWithTypeAndDate(
          any(),
          any(),
          any(),
        ),
      ).thenAnswer(
        (invocation) => Future.value(
          PdfDocumentMetadata(
            mimeType: 'mimeType',
            pages: [PdfDocumentPage(content: '')],
            rotation: 0,
            scale: 0,
            supportedMimeTypes: [],
            width: 0,
          ),
        ),
      );

      when(() => mockDocumentRepository.save(any())).thenAnswer(
        (invocation) => Future.value(''),
      );

      when(() => mockMetadataRepository.save(any())).thenAnswer(
        (invocation) => Future.value(),
      );
    },
    act: (bloc) => bloc.downloadAndSaveAutoIdCard(
      testPolicySummary,
      testPolicyDetail,
      isTemporary: false,
    ),
    expect: () =>
        [isA<SaveAutoIdCardProcessing>(), isA<SaveAutoIdCardSuccess>()],
    verify: (bloc) {
      verify(
        () => mockDocumentClient.getAutoIdCardWithTypeAndDate(
          any(),
          any(),
          any(),
        ),
      ).called(1);

      verify(() => mockDocumentRepository.save(any())).called(1);

      verify(() => mockMetadataRepository.save(any())).called(1);
    },
  );

  blocTest<SaveAutoIdCardCubit, SaveAutoIdCardState>(
    ' When view the PDF, saving the PDF, and saving document metadata all succeed, move to the success saved state',
    build: () => SaveAutoIdCardCubit(
      documentRepository: mockDocumentRepository,
      documentInformationRepository: TfbDocumentInformationRepository(
        client: mockDocumentClient,
      ),
      metadataRepository: mockMetadataRepository,
    ),
    setUp: () {
      when(
        () => mockDocumentClient.getAutoIdCardWithTypeAndDate(
          any(),
          any(),
          any(),
        ),
      ).thenAnswer(
        (invocation) => Future.value(
          PdfDocumentMetadata(
            mimeType: 'mimeType',
            pages: [PdfDocumentPage(content: '')],
            rotation: 0,
            scale: 0,
            supportedMimeTypes: [],
            width: 0,
          ),
        ),
      );

      when(() => mockDocumentRepository.save(any())).thenAnswer(
        (invocation) => Future.value(''),
      );

      when(() => mockMetadataRepository.save(any())).thenAnswer(
        (invocation) => Future.value(),
      );
    },
  );

  blocTest<SaveAutoIdCardCubit, SaveAutoIdCardState>(
    'Removing a saved ID card should move to the [SaveAutoIdCardUncached] state',
    build: () => SaveAutoIdCardCubit(
      documentRepository: mockDocumentRepository,
      documentInformationRepository: TfbDocumentInformationRepository(
        client: mockDocumentClient,
      ),
      metadataRepository: mockMetadataRepository,
    ),
    seed: () => SaveAutoIdCardSuccess(
      idCardMetadata: TfbAutoPolicyDocumentMetadata(
        policyNumber: '',
        vehicleDisplayTitles: [],
        expirationDate: DateTime.now(),
        documentPath: '',
        id: 'id',
      ),
    ),
    setUp: () {
      when(() => mockMetadataRepository.delete(any()))
          .thenAnswer((invocation) => Future.value());

      when(() => mockDocumentRepository.delete(any()))
          .thenAnswer((invocation) => Future.value());
    },
    act: (bloc) => bloc.removeSavedAutoIdCard(
      TfbAutoPolicyDocumentMetadata(
        policyNumber: '',
        vehicleDisplayTitles: [],
        expirationDate: DateTime.now(),
        documentPath: 'documentFilePath',
        id: 'policyMetadataId',
      ),
    ),
    expect: () =>
        [isA<SaveAutoIdCardProcessing>(), isA<SaveAutoIdCardUncached>()],
  );

  blocTest<SaveAutoIdCardCubit, SaveAutoIdCardState>(
    'When removing the auto id card, but the metadata remove fails, move to the failed [SaveAutoIdCardSavedError] state',
    build: () => SaveAutoIdCardCubit(
      documentRepository: mockDocumentRepository,
      documentInformationRepository: TfbDocumentInformationRepository(
        client: mockDocumentClient,
      ),
      metadataRepository: mockMetadataRepository,
    ),
    seed: () => SaveAutoIdCardSuccess(
      idCardMetadata: TfbAutoPolicyDocumentMetadata(
        policyNumber: '',
        vehicleDisplayTitles: [],
        expirationDate: DateTime.now(),
        documentPath: '',
        id: 'id',
      ),
    ),
    setUp: () {
      when(() => mockMetadataRepository.delete(any()))
          .thenThrow(Exception('ERROR SAVING METADATA'));

      when(() => mockDocumentRepository.delete(any()))
          .thenAnswer((invocation) => Future.value());
    },
    act: (bloc) => bloc.removeSavedAutoIdCard(
      TfbAutoPolicyDocumentMetadata(
        policyNumber: '',
        vehicleDisplayTitles: [],
        expirationDate: DateTime.now(),
        documentPath: 'documentFilePath',
        id: 'policyMetadataId',
      ),
    ),
    expect: () =>
        [isA<SaveAutoIdCardProcessing>(), isA<SaveAutoIdCardFailure>()],
    verify: (bloc) {
      verify(() => mockMetadataRepository.delete(any())).called(1);
      verifyNever(() => mockDocumentRepository.delete(any()));
    },
  );
  blocTest<SaveAutoIdCardCubit, SaveAutoIdCardState>(
    'If an auto id card is saved and the [getIsIdCardSaved] call is made '
    'successfully, the state should move to [SaveAutoIdCardSaved]',
    build: () => SaveAutoIdCardCubit(
      documentRepository: mockDocumentRepository,
      documentInformationRepository: TfbDocumentInformationRepository(
        client: mockDocumentClient,
      ),
      metadataRepository: mockMetadataRepository,
    ),
    setUp: () {
      when(() => mockMetadataRepository.read(any())).thenAnswer(
        (invocation) => Future.value(
          TfbAutoPolicyDocumentMetadata(
            policyNumber: '',
            vehicleDisplayTitles: [],
            expirationDate: DateTime.now(),
            documentPath: 'documentPath',
            id: 'id',
          ),
        ),
      );
    },
    act: (bloc) => bloc.getIsIdCardSaved(testPolicySummary),
    expect: () =>
        [isA<SaveAutoIdCardProcessing>(), isA<SaveAutoIdCardSuccess>()],
  );

  blocTest<SaveAutoIdCardCubit, SaveAutoIdCardState>(
    'If an auto id card is NOT saved and the [getIsIdCardSaved] call is made '
    'successfully, the state should move to [SaveAutoIdCardUncached]',
    build: () => SaveAutoIdCardCubit(
      documentRepository: mockDocumentRepository,
      documentInformationRepository: TfbDocumentInformationRepository(
        client: mockDocumentClient,
      ),
      metadataRepository: mockMetadataRepository,
    ),
    setUp: () {
      when(() => mockMetadataRepository.read(any())).thenAnswer(
        (invocation) => Future.value(),
      );
    },
    act: (bloc) => bloc.getIsIdCardSaved(testPolicySummary),
    expect: () =>
        [isA<SaveAutoIdCardProcessing>(), isA<SaveAutoIdCardUncached>()],
  );
}
