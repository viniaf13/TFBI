import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/paperless_billing/paperless_billing_details.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class PaperlessBillingContainer extends StatelessWidget {
  const PaperlessBillingContainer({required this.policy, super.key});

  final PolicySummary policy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kSpacingMedium),
      decoration: BoxDecoration(
        color: TfbBrandColors.white,
        borderRadius: context.radii.defaultRadius,
      ),
      child: Column(
        children: [PaperlessBillingDetails(policy: policy)],
      ),
    );
  }
}
