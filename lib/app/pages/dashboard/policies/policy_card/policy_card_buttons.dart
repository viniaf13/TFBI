import 'package:flutter/widgets.dart';
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/extensions/separated_list.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class PolicyCardButtons extends StatelessWidget {
  const PolicyCardButtons({required this.summary, super.key});

  final PolicySummary summary;

  @override
  Widget build(BuildContext context) {
    final children = [
      if (summary.currentAmountDueIsNotZero) ...[
        if (summary.isAutoPayEnabled)
          Expanded(
            child: TfbFilledButton.secondaryTextButton(
              onPressed: () => context.navigator.pushAutoPayEnrollment(summary),
              title: context.getLocalizationOf.manageAutoPay,
              style: context.tfbText.bodyMediumSmall
                  .copyWith(color: TfbBrandColors.blueHighest),
            ),
          )
        else if (summary.canMakeAPayment)
          Expanded(
            child: TfbFilledButton.secondaryTextButton(
              onPressed: () {
                final String screenName = context.screenName;
                TfbAnalytics.instance.track(
                  MakeAPaymentEvent(
                    policyNumber: summary.policyNumber,
                    policyType: summary.policyType.name(context),
                    screenName: screenName,
                  ),
                );
                context.navigator.pushBillingDetailPage(
                  summary,
                );
                context.navigator.pushMakeAPaymentDialog(
                  summary,
                );
              },
              title: context.getLocalizationOf.makePaymentCta,
              style: context.tfbText.bodyMediumSmall
                  .copyWith(color: TfbBrandColors.blueHighest),
            ),
          ),
      ],
      Expanded(
        child: TfbFilledButton.secondaryTextButton(
          onPressed: () {
            context.navigator.pushPolicyDetailPage(summary);
          },
          title: context.getLocalizationOf.policyOverviewCta,
          style: context.tfbText.bodyMediumSmall
              .copyWith(color: TfbBrandColors.blueHighest),
        ),
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children.separated(
        const SizedBox(
          width: kSpacingSmall,
        ),
      ),
    );
  }
}
