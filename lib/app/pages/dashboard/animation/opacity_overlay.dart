import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

class OpacityOverlay extends StatefulWidget {
  const OpacityOverlay({
    super.key,
  });

  @override
  State<OpacityOverlay> createState() => _OpacityOverlayState();

  static Duration animationDuration = const Duration(seconds: 1);
}

class _OpacityOverlayState extends State<OpacityOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController opacityAnimationController;

  @override
  void initState() {
    super.initState();

    opacityAnimationController = AnimationController(
      vsync: this,
      duration: OpacityOverlay.animationDuration,
    );
  }

  @override
  void dispose() {
    opacityAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      getDefaultPageTransitionDuration(),
      opacityAnimationController.forward,
    );

    return AnimatedBuilder(
      animation: opacityAnimationController,
      builder: (context, child) {
        return IgnorePointer(
          child: Container(
            color: TfbBrandColors.blueHighest.withAlpha(
              ((1 - opacityAnimationController.value) * 255).toInt(),
            ),
          ),
        );
      },
    );
  }
}
