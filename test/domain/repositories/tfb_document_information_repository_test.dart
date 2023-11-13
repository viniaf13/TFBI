import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document/pdf_document_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document/pdf_document_page.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_document_request.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_list_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_list_request.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_document_information_repository.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

import '../../mocks/mock_policy_lookup_client.dart';

class MockTfbDocumentInformationClient extends Mock
    implements TfbDocumentInformationClient {}

void main() {
  group('TfbDocumentInformationRepository', () {
    late TfbDocumentInformationRepository repository;
    late MockTfbDocumentInformationClient mockClient;

    final mockPolicyDocumentRequest = PolicyDocumentRequest(
      documentId: '123',
      policyNumber: '123',
      policySubtype: '123',
      policyType: PolicyType.txPersonalAuto,
    );

    setUp(() {
      mockClient = MockTfbDocumentInformationClient();
      repository = TfbDocumentInformationRepository(client: mockClient);

      registerFallbackValue(mockPolicyDocumentRequest);
    });

    test('getPolicyDocuments should call client method', () async {
      const policyNumber = '12345';
      final policyListRequest = PolicyListRequest(
        policyNumber: '',
        policySubtype: '',
        policyType: PolicyType.txPersonalAuto,
        locationType: '',
      );

      when(
        () => mockClient.getPolicyDocuments(
          policyNumber,
          policyListRequest,
        ),
      ).thenAnswer((_) async => <PolicyListMetadata>[]);

      await repository.getPolicyDocuments(
        policyNumber,
        policyListRequest,
      );

      verify(
        () => mockClient.getPolicyDocuments(
          policyNumber,
          policyListRequest,
        ),
      ).called(1);
    });

    test('getPolicyDocumentMetadata should call client method', () async {
      final policySummary = MockPolicy.createPolicySummary();

      final policy = PdfDocumentMetadata(
        mimeType: 'test',
        pages: [PdfDocumentPage(content: 'content')],
        rotation: 0,
        scale: 0,
        width: 0,
        supportedMimeTypes: ['mimeType'],
      );

      when(
        () => mockClient.getPolicyDocumentMetadata(
          any(),
          any(),
        ),
      ).thenAnswer((invocation) => Future.value(policy));

      await repository.getPolicyDocumentMetadata(
        policySummary.policyNumber,
        mockPolicyDocumentRequest,
      );

      verify(
        () => mockClient.getPolicyDocumentMetadata(
          any(),
          any(),
        ),
      ).called(1);
    });
  });
}
