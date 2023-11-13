import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/shared/constants/spacing.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';

class LossAndDamageHeader extends StatelessWidget {
  const LossAndDamageHeader({
    required this.dateOfLoss,
    super.key,
  });

  final String dateOfLoss;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.getLocalizationOf.lossAndDamageInformationTitle,
          style: context.tfbText.subHeaderRegular.copyWith(
            color: TfbBrandColors.blueHighest,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: kSpacingSmall,
          ),
          child: Text(
            context.getLocalizationOf.lossAndDamageInformationSubtitle(
              dateOfLoss,
            ),
            style: context.tfbText.bodyRegularLarge.copyWith(
              color: TfbBrandColors.grayHighest,
            ),
          ),
        ),
      ],
    );
  }
}
