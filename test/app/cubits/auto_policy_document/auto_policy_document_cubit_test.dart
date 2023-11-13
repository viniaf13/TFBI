import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/auto_policy_document/auto_policy_document_cubit.dart';
import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/models/models.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_list_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_list_request.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_static_document.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_static_documents_request.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_document_information_repository.dart';

import '../../../mocks/mock_policy_lookup_client.dart';
import '../../../mocks/mock_tfb_document_information_client.dart';

void main() {
  late TfbDocumentInformationClient mockDocumentInformationClient;

  setUp(() {
    mockDocumentInformationClient = MockTfbDocumentInformationClient();

    registerFallbackValue(testPolicySummary);

    registerFallbackValue(
      PolicyListRequest(
        policyNumber: '123',
        policySubtype: '123',
        policyType: PolicyType.txPersonalAuto,
      ),
    );
    registerFallbackValue(
      PolicyStaticDocumentsRequest(
        expirationDate: '123',
        policySymbol: '123',
      ),
    );
  });

  test(
      '[AutoPolicyDocumentCubit] should start in the [AutoPolicyDocumentInitial] state',
      () {
    expect(
      AutoPolicyDocumentCubit(
        documentInformationRepository: TfbDocumentInformationRepository(
          client: mockDocumentInformationClient,
        ),
      ).state,
      isA<AutoPolicyDocumentInitial>(),
    );
  });

  blocTest<AutoPolicyDocumentCubit, AutoPolicyDocumentState>(
    'If the document client [getPolicyDocumentList] call fails, move to a [AutoPolicyFailure] state',
    build: () => AutoPolicyDocumentCubit(
      documentInformationRepository: TfbDocumentInformationRepository(
        client: mockDocumentInformationClient,
      ),
    ),
    setUp: () {
      when(
        () => mockDocumentInformationClient.getPolicyDocuments(any(), any()),
      ).thenThrow(Exception('ERROR'));
    },
    act: (bloc) => bloc.getPolicyDocumentList(testPolicySummary),
    expect: () =>
        [isA<AutoPolicyDocumentProcessing>(), isA<AutoPolicyDocumentError>()],
  );

  blocTest<AutoPolicyDocumentCubit, AutoPolicyDocumentState>(
    'If the document client [getPolicyStaticDocuments] call fails, move to a [AutoPolicyFailure] state',
    build: () => AutoPolicyDocumentCubit(
      documentInformationRepository: TfbDocumentInformationRepository(
        client: mockDocumentInformationClient,
      ),
    ),
    setUp: () {
      when(
        () => mockDocumentInformationClient.getPolicyDocuments(any(), any()),
      ).thenAnswer((invocation) => Future.value(<PolicyListMetadata>[]));
      when(
        () => mockDocumentInformationClient.getPolicyStaticDocuments(any()),
      ).thenThrow(Exception('ERROR'));
    },
    act: (bloc) => bloc.getPolicyDocumentList(testPolicySummary),
    expect: () =>
        [isA<AutoPolicyDocumentProcessing>(), isA<AutoPolicyDocumentError>()],
  );

  blocTest<AutoPolicyDocumentCubit, AutoPolicyDocumentState>(
    'If the document client [getPolicyDocumentList] call succeeds, move to a [AutoPolicySuccess] state',
    build: () => AutoPolicyDocumentCubit(
      documentInformationRepository: TfbDocumentInformationRepository(
        client: mockDocumentInformationClient,
      ),
    ),
    setUp: () {
      when(
        () => mockDocumentInformationClient.getPolicyDocuments(any(), any()),
      ).thenAnswer((invocation) => Future.value(<PolicyListMetadata>[]));
      when(
        () => mockDocumentInformationClient.getPolicyStaticDocuments(any()),
      ).thenAnswer((invocation) => Future.value(<PolicyStaticDocument>[]));
    },
    act: (bloc) => bloc.getPolicyDocumentList(testPolicySummary),
    expect: () =>
        [isA<AutoPolicyDocumentProcessing>(), isA<AutoPolicyDocumentSuccess>()],
  );
}

final testPolicySummary = MockPolicy.createPolicySummary();
final testPolicyDetail = MockPolicy.createAutoPolicyDetail();
