import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class TextWithPdf extends StatelessWidget {
  const TextWithPdf({required this.label, this.onTap, super.key});

  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          TfbAssetStrings.fileTextIcon,
          width: 16,
          height: 16,
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: kSpacingSmall),
            child: Semantics(
              button: true,
              child: GestureDetector(
                onTap: onTap,
                child: Text(
                  label,
                  style: context.tfbText.bodyMediumLarge.copyWith(
                    color: TfbBrandColors.blueHigh,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
