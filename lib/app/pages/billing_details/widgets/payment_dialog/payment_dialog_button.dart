import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class PaymentDialogButton extends StatelessWidget {
  const PaymentDialogButton({
    required this.onPressed,
    required this.title,
    required this.subtitle,
    super.key,
  });

  final VoidCallback onPressed;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    // Can't use the TfbFilledButton because it restricts the height of the
    // child widget to 50 pixels
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: TfbBrandColors.blueLowest,
        foregroundColor: TfbBrandColors.blueHighest,
        padding: const EdgeInsets.symmetric(horizontal: kSpacingMedium),
        splashFactory: NoSplash.splashFactory,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: kSpacingMedium),
        decoration: BoxDecoration(
          borderRadius: context.radii.defaultRadius,
        ),
        constraints: const BoxConstraints(minHeight: 80),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: kSpacingExtraSmall),
                    child: Text(
                      title,
                      style: context.tfbText.bodyMediumSmall
                          .copyWith(color: TfbBrandColors.blueHighest),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: context.tfbText.caption
                        .copyWith(color: TfbBrandColors.blueHighest),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: kSpacingMedium),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: TfbBrandColors.blueHighest,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
