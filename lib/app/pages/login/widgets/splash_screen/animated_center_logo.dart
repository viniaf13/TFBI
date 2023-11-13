import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/shared/constants/tfb_asset_strings.dart';

class AnimatedCenterLogo extends StatelessWidget {
  const AnimatedCenterLogo({
    required this.controller,
    required this.curve,
    required this.logoKey,
    super.key,
  });

  final AnimationController controller;
  final Curve curve;
  final GlobalKey logoKey;

  @override
  Widget build(BuildContext context) {
    final opacityTween = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: curve,
      ),
    );

    return Align(
      child: AspectRatio(
        aspectRatio: 1.5,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 62),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 112,
                child: Column(
                  children: [
                    Expanded(
                      flex: 111,
                      child: Transform.translate(
                        offset: const Offset(12, 12),
                        child: Opacity(
                          opacity: opacityTween.value.floorToDouble(),
                          child: Image.asset(
                            TfbAssetStrings.splitLogoIcon,
                            key: logoKey,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 82,
                      child: SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 158,
                child: Column(
                  children: [
                    const Expanded(
                      flex: 100,
                      child: SizedBox.shrink(),
                    ),
                    Expanded(
                      flex: 100,
                      child: Transform.translate(
                        offset: const Offset(-12, -12),
                        child: Opacity(
                          opacity: opacityTween.value,
                          child: Image.asset(
                            TfbAssetStrings.splitLogoText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
