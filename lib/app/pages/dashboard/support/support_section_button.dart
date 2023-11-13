import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class SupportSectionButton extends StatelessWidget {
  const SupportSectionButton({
    required this.label,
    required this.onTap,
    super.key,
  });

  final String label;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: kSpacingSmall,
        left: kSpacingSmall,
        right: kSpacingSmall,
      ),
      child: Semantics(
        button: true,
        child: GestureDetector(
          onTap: onTap,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: TfbBrandColors.blueLowest,
              borderRadius: context.radii.defaultRadius,
            ),
            child: Padding(
              padding: const EdgeInsets.all(kSpacingMediumSmall),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: context.tfbText.bodyMediumLarge.copyWith(
                      color: TfbBrandColors.blueHighest,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                    color: TfbBrandColors.blueMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
