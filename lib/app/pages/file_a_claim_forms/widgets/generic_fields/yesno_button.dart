import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

// This button reflects state back up the tree rather than maintaining
// its own state. This is vital because it is not an independent
// checkbox, but rather part of a radio group.

enum YesNoButtonKind { yes, no }

class YesNoButton extends StatelessWidget {
  const YesNoButton({
    required this.value,
    required this.kind,
    required this.onTap,
    super.key,
  });

  final bool value;
  final YesNoButtonKind kind;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final buttonKindIsYes = kind == YesNoButtonKind.yes;
    return Semantics(
      selected: value,
      label: buttonKindIsYes
          ? context.getLocalizationOf.yes
          : context.getLocalizationOf.no,
      onTap: onTap,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Column(
          children: [
            const SizedBox(
              height: kSpacingMedium,
            ),
            Row(
              children: [
                SizedBox(
                  width: 18,
                  height: 18,
                  child: Stack(
                    children: [
                      Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: context.radii.tiny,
                            side: const BorderSide(
                              width: 2,
                              color: TfbBrandColors.grayMedium,
                            ),
                          ),
                        ),
                      ),
                      if (value) ...[
                        Image.asset(
                          TfbAssetStrings.checkmarkIcon,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(
                  width: kSpacingSmall,
                ),
                Text(
                  buttonKindIsYes
                      ? context.getLocalizationOf.yes
                      : context.getLocalizationOf.no,
                  style: context.tfbText.bodyMediumSmall.copyWith(
                    color: TfbBrandColors.blueHighest,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kSpacingExtraSmall,
            ),
          ],
        ),
      ),
    );
  }
}
