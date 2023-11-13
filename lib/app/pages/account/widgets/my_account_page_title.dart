import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class MyAccountPageTitle extends StatelessWidget {
  const MyAccountPageTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => DevUtilsModal.show(context),
      child: Padding(
        padding: const EdgeInsets.only(bottom: kSpacingMedium),
        child: Text(
          context.getLocalizationOf.myAccountPageTitle,
          style: context.tfbText.header3.copyWith(
            color: TfbBrandColors.blueHighest,
          ),
        ),
      ),
    );
  }
}
