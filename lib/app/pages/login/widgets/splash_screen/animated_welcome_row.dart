import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class AnimatedWelcomeRow extends StatelessWidget {
  const AnimatedWelcomeRow({
    required this.controller,
    required this.curve,
    required this.starWidgetKey,
    super.key,
  });

  final AnimationController controller;
  final Curve curve;
  final GlobalKey<State<StatefulWidget>> starWidgetKey;

  @override
  Widget build(BuildContext context) {
    final opacityTween = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: curve,
      ),
    );

    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top + kSpacingMedium,
      ),
      child: GestureDetector(
        onLongPress: () => DevUtilsModal.show(context),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(
                right: kSpacingSmall,
                left: kSpacingMedium,
              ),
              height: 60,
              width: 60,
              child: Opacity(
                opacity: opacityTween.value.floorToDouble(),
                child: Image.asset(
                  TfbAssetStrings.splitLogoIcon,
                  key: starWidgetKey,
                ),
              ),
            ),
            Opacity(
              opacity: opacityTween.value,
              child: Text(
                context.getLocalizationOf.loginWelcomeTitle,
                style: context.tfbText.header1
                    .copyWith(color: TfbBrandColors.blueHighest),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
