import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/policy_document/policy_document_page.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_list_metadata.dart';

import '../mock_policy_lookup_client.dart';
import '../models/mock_policy_metadata.dart';

abstract class MockPolicyDocumentPageParameters {
  static PolicyDocumentPageParameters getParams() {
    final mockPolicySummary = MockPolicy.createPolicySummary();
    final PolicyListMetadata policyListMetadata =
        MockPolicyMetadata.getPolicyListMetadata();

    return PolicyDocumentPageParameters(
      policySummary: mockPolicySummary,
      documentMetadata: policyListMetadata,
      pdfViewerEventsParameters: PdfViewerEventsParameters(
        screenName: 'screen name',
        cta: 'cta',
      ),
    );
  }
}
