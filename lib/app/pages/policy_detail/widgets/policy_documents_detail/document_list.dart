import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/policy_document/policy_document_page.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_documents_detail/text_with_pdf.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_list_metadata.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class DocumentList extends StatelessWidget {
  const DocumentList({
    required this.title,
    required this.policySummary,
    required this.documents,
    super.key,
  });

  final String title;
  final PolicySummary policySummary;
  final List<PolicyListMetadata> documents;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.tfbText.bodyRegularSmall
              .copyWith(color: TfbBrandColors.grayHighest),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: kSpacingSmall, left: kSpacingSmall),
          child: Column(
            children: documents
                .map(
                  (document) => TextWithPdf(
                    label: document.labelDescription,
                    onTap: () => context.navigator.pushPolicyDocumentPdfPage(
                      PolicyDocumentPageParameters(
                        policySummary: policySummary,
                        documentMetadata: document,
                        pdfViewerEventsParameters: PdfViewerEventsParameters(
                          screenName: context.screenName,
                          cta: document.labelDescription,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
