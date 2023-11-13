import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/shared/constants/tfb_asset_strings.dart';

class AnimatedHeroStar extends StatelessWidget {
  const AnimatedHeroStar({
    required this.curve,
    required this.controller,
    required this.startRenderBox,
    required this.endRenderBox,
    super.key,
  });

  final Curve curve;
  final AnimationController controller;
  final RenderBox? startRenderBox;
  final RenderBox? endRenderBox;

  @override
  Widget build(BuildContext context) {
    final startStarPos = startRenderBox?.localToGlobal(Offset.zero);
    final endStarPos = endRenderBox?.localToGlobal(Offset.zero);

    final startStarX = startStarPos?.dx ?? 0;
    final endStarX = endStarPos?.dx ?? 0;
    final starXTween = Tween<double>(
      begin: startStarX,
      end: endStarX,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: curve,
      ),
    );

    final startStarY = startStarPos?.dy ?? 0;
    final endStarY = endStarPos?.dy ?? 0;
    final starYTween = Tween<double>(
      begin: startStarY,
      end: endStarY,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: curve,
      ),
    );

    final startStarHeight = startRenderBox?.size.height ?? 0;
    final endStarHeight = endRenderBox?.size.height ?? 0;
    final starHeightTween = Tween<double>(
      begin: startStarHeight,
      end: endStarHeight,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: curve,
      ),
    );

    final startStarWidth = startRenderBox?.size.width ?? 0;
    final endStarWidth = endRenderBox?.size.width ?? 0;
    final starWidthTween = Tween<double>(
      begin: startStarWidth,
      end: endStarWidth,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: curve,
      ),
    );

    return Positioned(
      left: starXTween.value,
      top: starYTween.value,
      child: Container(
        height: starHeightTween.value,
        width: starWidthTween.value,
        color: Colors.transparent,
        child: Image.asset(TfbAssetStrings.splitLogoIcon),
      ),
    );
  }
}
