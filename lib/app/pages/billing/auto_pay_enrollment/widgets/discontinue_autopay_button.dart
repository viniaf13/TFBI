import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class DiscontinueAutoPayButton extends StatelessWidget {
  const DiscontinueAutoPayButton({required this.policy, super.key});

  final PolicySummary policy;

  @override
  Widget build(BuildContext context) {
    final user = context.user;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kSpacingMedium),
      child: TfbFilledButton.textOnlyButton(
        title: context.getLocalizationOf.autopayEnrollDiscontinueCTA,
        style: context.tfbText.bodyBoldSmall.copyWith(
          color: TfbBrandColors.redHigh,
        ),
        onPressed: user != null
            ? () => context.navigator.pushDiscontinueAutoPayEnrollment(policy)
            : null,
      ),
    );
  }
}
