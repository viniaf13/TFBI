import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/constants/tfb_asset_strings.dart';

class ProcessingSnackbarIcon extends StatefulWidget {
  const ProcessingSnackbarIcon({super.key});

  @override
  State<ProcessingSnackbarIcon> createState() => _ProcessingSnackbarIcon();
}

class _ProcessingSnackbarIcon extends State<ProcessingSnackbarIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * 3.141592654,
          child: child,
        );
      },
      child: const ImageIcon(
        AssetImage(TfbAssetStrings.loadingSpinnerIcon),
        color: TfbBrandColors.blueHighest,
      ),
    );
  }
}
