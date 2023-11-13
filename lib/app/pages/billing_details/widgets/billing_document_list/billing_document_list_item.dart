import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/document_events.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_document_pdf_viewer/billing_document_pdf_viewer_page.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/billing_list_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class BillingDocumentListItem extends StatelessWidget {
  const BillingDocumentListItem({
    required this.item,
    required this.isFirst,
    required this.isLast,
    super.key,
  });

  final BillingListMetadata item;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    void onTap() => context.navigator.pushBillingDocumentPdfViewerPage(
          BillingDocumentPdfViewerPageParameters(
            policySummary: context.read<PolicySummary>(),
            metadata: item,
            pdfViewerEventsParameters: PdfViewerEventsParameters(
              screenName: context.screenName,
              cta: DocumentEventViewOptions.recurringPaymentSchedule.value,
            ),
          ),
        );

    return Column(
      children: [
        Semantics(
          explicitChildNodes: true,
          button: true,
          onTap: onTap,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.only(
                top: isFirst ? 0 : 14,
                bottom: 14,
              ),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) {
                      return Expanded(
                        child: Text(
                          item.labelDescription,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.tfbText.bodyMediumSmall.copyWith(
                            color: TfbBrandColors.blueHigh,
                          ),
                        ),
                      );
                    },
                  ),
                  Flexible(
                    child: Text(
                      item.date,
                      style: context.tfbText.bodyRegularSmall,
                      maxLines: 1,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SeparatorLine(
          padding: isLast
              ? const EdgeInsets.only(bottom: kSpacingSmall)
              : EdgeInsets.zero,
        ),
      ],
    );
  }
}
