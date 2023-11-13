import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/enable_auto_pay_event.dart';
import 'package:txfb_insurance_flutter/app/analytics/tfb_analytics.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class BillingEnableAutoPayCta extends StatelessWidget {
  const BillingEnableAutoPayCta({required this.policy, super.key});

  final PolicySummary policy;

  @override
  Widget build(BuildContext context) {
    return TfbFilledButton.textOnlyButton(
      title: context.getLocalizationOf.enableAutoPay,
      style: context.tfbText.bodyMediumLarge
          .copyWith(color: TfbBrandColors.blueHigh),
      padding: const EdgeInsets.only(top: kSpacingMedium),
      onPressed: () {
        context.navigator.pushAutoPayEnrollment(policy);
        TfbAnalytics.instance.track(
          EnableAutoPayEvent(
            policyType: policy.policyType.name(context),
            policyNumber: policy.policyNumber,
            screenName: context.screenName,
          ),
        );
      },
    );
  }
}
