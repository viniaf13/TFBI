import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

class SeparatorLine extends StatelessWidget {
  const SeparatorLine({
    this.padding,
    super.key,
    this.color = TfbBrandColors.grayMedium,
  });

  final EdgeInsets? padding;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: kSpacingMedium),
      child: Container(
        height: 1,
        color: color,
      ),
    );
  }
}
