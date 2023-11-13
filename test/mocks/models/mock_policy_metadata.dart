import 'package:txfb_insurance_flutter/domain/models/auto_policy_document_metadata_repository/tfb_auto_policy_document_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_list_metadata.dart';

abstract class MockPolicyMetadata {
  static TfbAutoPolicyDocumentMetadata getDocumentMetadata() {
    return TfbAutoPolicyDocumentMetadata(
      policyNumber: '12345',
      vehicleDisplayTitles: ['2022 Uno mile'],
      expirationDate: DateTime.now(),
      documentPath: '/',
      id: 'UDID',
    );
  }

  static PolicyListMetadata getPolicyListMetadata() {
    return PolicyListMetadata(
      date: '05/05/2022',
      documentId: 'documentId',
      formDescription: 'formDescription',
      labelDescription: 'labelDescription',
      pageNumber: 1,
      versionId: '1',
    );
  }
}
