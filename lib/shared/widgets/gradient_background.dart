import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_loading_overlay.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    required this.child,
    required this.gradient,
    this.showLoadingOverlay = false,
    super.key,
  });

  final Widget child;
  final LinearGradient gradient;
  final bool showLoadingOverlay;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: gradient,
          ),
        ),
        child,
        if (showLoadingOverlay) const TfbLoadingOverlay(),
      ],
    );
  }
}
