import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/current_bill/current_bill_page.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/extensions/separated_list.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class PolicyDetailsCtaRow extends StatelessWidget {
  const PolicyDetailsCtaRow({
    required this.policySummary,
    super.key,
  });

  final PolicySummary policySummary;

  @override
  Widget build(BuildContext context) {
    final children = [
      if (policySummary.isAutoPayEnabled)
        Expanded(
          child: TfbFilledButton.primaryTextButton(
            onPressed: () =>
                context.navigator.pushAutoPayEnrollment(policySummary),
            title: context.getLocalizationOf.manageAutoPay,
            style: context.tfbText.bodyMediumSmall
                .copyWith(color: TfbBrandColors.white),
          ),
        )
      else if (policySummary.canMakeAPayment)
        Expanded(
          child: TfbFilledButton.primaryTextButton(
            onPressed: () {
              final String screenName = context.screenName;
              TfbAnalytics.instance.track(
                MakeAPaymentEvent(
                  policyNumber: policySummary.policyNumber,
                  policyType: policySummary.policyType.name(context),
                  screenName: screenName,
                ),
              );
              context.navigator.pushMakeAPaymentDialog(policySummary);
            },
            title: context.getLocalizationOf.makePaymentCta,
            style: context.tfbText.bodyMediumSmall
                .copyWith(color: TfbBrandColors.white),
          ),
        ),
      if (policySummary.canViewCurrentBill)
        Expanded(
          child: TfbFilledButton.primaryTextButton(
            onPressed: () => context.navigator.pushCurrentBillPage(
              CurrentBillPageParameters(
                policySummary: policySummary,
                pdfViewerEventsParameters: PdfViewerEventsParameters(
                  screenName: context.screenName,
                  cta: DocumentEventViewOptions.viewCurrentBill.value,
                ),
              ),
            ),
            title: context.getLocalizationOf.viewCurrentBillCta,
            style: context.tfbText.bodyMediumSmall
                .copyWith(color: TfbBrandColors.white),
          ),
        ),
    ];

    if (children.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        const SizedBox(height: kSpacingMedium),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children.separated(const SizedBox(width: kSpacingSmall)),
        ),
      ],
    );
  }
}
