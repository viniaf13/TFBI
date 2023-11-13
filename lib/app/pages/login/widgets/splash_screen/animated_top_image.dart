import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/shared/constants/tfb_asset_strings.dart';

class AnimatedTopImage extends StatelessWidget {
  const AnimatedTopImage({
    required this.controller,
    required this.curve,
    super.key,
  });

  final AnimationController controller;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final mainTween = Tween<double>(
      begin: 0,
      end: 40 + 72,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: curve,
      ),
    );

    return Transform.translate(
      offset: Offset(0, -mainTween.value),
      child: Padding(
        padding: const EdgeInsets.only(top: 14),
        child: Image.asset(
          TfbAssetStrings.splashTop,
        ),
      ),
    );
  }
}
