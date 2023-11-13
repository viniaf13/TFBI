import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/constants/spacing.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

class DecoratedContainer extends StatelessWidget {
  const DecoratedContainer({
    required this.child,
    this.height,
    this.color,
    super.key,
  });

  final Widget child;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(kSpacingMedium),
      decoration: ShapeDecoration(
        color: color ?? TfbBrandColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: context.radii.defaultRadius,
        ),
      ),
      child: child,
    );
  }
}
