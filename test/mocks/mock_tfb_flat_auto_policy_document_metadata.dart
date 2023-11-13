import 'package:txfb_insurance_flutter/domain/models/auto_policy_document_metadata_repository/tfb_flat_auto_policy_document_metadata.dart';

abstract class MockTfbFlatAutoPolicyDocumentMetadata {
  static TfbFlatAutoPolicyDocumentMetadata getAutoPolicyDocumentMetadata() {
    return TfbFlatAutoPolicyDocumentMetadata(
      vehicleName: 'vehicleName',
      documentPath: 'documentPath',
      expirationDate: DateTime.now(),
      id: 'id',
      policyNumber: 'policyNumber',
    );
  }
}
