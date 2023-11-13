import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/policy_document/policy_document_page.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_documents_detail/text_with_pdf.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_static_document.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class PolicyStaticDocuments extends StatelessWidget {
  const PolicyStaticDocuments({
    required this.policySummary,
    required this.policyStaticDocuments,
    super.key,
  });

  final PolicySummary policySummary;
  final List<PolicyStaticDocument> policyStaticDocuments;

  @override
  Widget build(BuildContext context) {
    final websiteUrl = context.getEnvironment<TfbEnvironment>().websiteUrl;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (policyStaticDocuments.isNotEmpty)
          ...policyStaticDocuments.map(
            (document) => TextWithPdf(
              label: document.documentTitle,
              onTap: () => context.navigator.pushPolicyDocumentPdfPage(
                PolicyDocumentPageParameters(
                  policySummary: policySummary,
                  documentUrl: websiteUrl + document.documentUrl,
                  documentName: document.documentTitle,
                  pdfViewerEventsParameters: PdfViewerEventsParameters(
                    screenName: context.screenName,
                    cta: document.documentTitle,
                  ),
                ),
              ),
            ),
          ),
        if (policyStaticDocuments.isEmpty)
          Text(
            context.getLocalizationOf.noStaticDocuments,
            style: context.tfbText.bodyRegularSmall.copyWith(
              color: TfbBrandColors.grayHighest,
            ),
          ),
      ],
    );
  }
}
