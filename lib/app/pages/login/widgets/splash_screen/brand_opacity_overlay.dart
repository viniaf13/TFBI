import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';

class BrandOpacityOverlay extends StatelessWidget {
  const BrandOpacityOverlay({
    required this.opacityProgress,
    required this.mainAnimationProgress,
    super.key,
  });

  final Animation<double> opacityProgress;
  final Animation<double> mainAnimationProgress;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: mainAnimationProgress.value == 1.0,
      child: Container(
        color:
            TfbBrandColors.blueHighest.withOpacity(1 - opacityProgress.value),
      ),
    );
  }
}
