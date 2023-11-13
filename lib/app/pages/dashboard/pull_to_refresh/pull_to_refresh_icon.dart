import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';

const pullToRefreshIconHeight = 52.0;

class PullToRefreshIcon extends StatelessWidget {
  const PullToRefreshIcon({
    required this.controller,
    required this.shouldShowShadow,
    super.key,
  });

  final IndicatorController controller;
  final bool shouldShowShadow;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IgnorePointer(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: controller.value.clamp(0, 1),
                child: Container(
                  margin: const EdgeInsets.only(top: kSpacingSmall),
                  height: pullToRefreshIconHeight,
                  width: pullToRefreshIconHeight,
                  decoration: BoxDecoration(
                    color: TfbBrandColors.blueLowest,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        pullToRefreshIconHeight / 2,
                      ),
                    ),
                    boxShadow: [
                      if (shouldShowShadow)
                        BoxShadow(
                          offset: const Offset(0, 4),
                          color: Colors.black.withAlpha(38),
                          blurRadius: 4,
                        ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: const TfbBrandLoadingIcon(
                      thickness: LoadingOverlayThickness.thick,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
