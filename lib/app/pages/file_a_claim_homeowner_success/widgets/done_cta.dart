import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/shared/constants/spacing.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_filled_button.dart';

class DoneCta extends StatelessWidget {
  const DoneCta({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: kSpacingExtraLarge,
        right: kSpacingExtraLarge,
        top: kSpacingMedium,
        bottom: kSpacingExtraLarge,
      ),
      child: SizedBox(
        height: 50,
        child: TfbFilledButton.primaryTextButton(
          title: context.getLocalizationOf.doneCTA,
          onPressed: context.navigator.popToTop,
        ),
      ),
    );
  }
}
