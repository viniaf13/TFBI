import 'package:txfb_insurance_flutter/domain/models/policy/policy_static_document.dart';

abstract class MockPolicyStaticDocument {
  static PolicyStaticDocument getStaticDocument() {
    return PolicyStaticDocument(
      documentId: 1,
      documentTitle: 'documentTitle',
      documentType: 'documentType',
      documentUrl: 'documentUrl',
    );
  }
}
