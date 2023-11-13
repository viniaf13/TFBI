import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class AutopaySubheader extends StatelessWidget {
  const AutopaySubheader({required this.policy, super.key});

  final PolicySummary policy;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: kSpacingMedium),
          child: Text(
            context.getLocalizationOf.autopayPolicyNumberLabel(
              policy.policyNumber,
            ),
            style: context.tfbText.bodyRegularLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: kSpacingMedium),
          child: Text(
            context.getLocalizationOf.autopayPolicyholderNameLabel(
              policy.policyInsuredName.toTitleCase(),
            ),
            style: context.tfbText.bodyRegularLarge,
          ),
        ),
      ],
    );
  }
}
