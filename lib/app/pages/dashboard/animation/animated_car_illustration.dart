import 'dart:math';

import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class AnimatedCarIllustration extends StatelessWidget {
  const AnimatedCarIllustration({
    required this.isAnimating,
    required this.backgroundImageSize,
    super.key,
  });

  final ValueNotifier<bool> isAnimating;
  final ValueNotifier<Size> backgroundImageSize;

  // The car image's width relative to the width of the background image
  final carWidthRatioToBackgroundImage = 0.17;

  // The car image's height relative to the height of the background image
  final carHeightRatioToBackgroundImage = 0.2348;

  // The ending point of the car, in relative coordinates inside the
  // background image, between 0-1.
  final carRelativeEndingPosition = const Point(0.48, 0.38);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([isAnimating, backgroundImageSize]),
      builder: (context, child) {
        if (backgroundImageSize.value.height == 0) {
          return const SizedBox.shrink();
        }

        WidgetsBinding.instance.addPostFrameCallback((_) async {
          // Wait for the page animation to complete
          await Future<void>.delayed(getDefaultPageTransitionDuration());

          if (!isAnimating.value) isAnimating.value = true;
        });

        final backgroundWidth = backgroundImageSize.value.width;
        final backgroundHeight = backgroundImageSize.value.height;

        final carHeight = backgroundHeight * carHeightRatioToBackgroundImage;
        final carWidth = backgroundWidth * carWidthRatioToBackgroundImage;

        final carStartingAndEndingPositionY =
            backgroundImageSize.value.height * carRelativeEndingPosition.y;
        final carEndingPositionX =
            backgroundWidth * carRelativeEndingPosition.x;
        final carStartingPositionX =
            -backgroundWidth * carWidthRatioToBackgroundImage;

        return AnimatedPositioned(
          duration: const Duration(milliseconds: 1500),
          curve: const Cubic(0, 0, 0.47, 1.07),
          top: carStartingAndEndingPositionY,
          right: isAnimating.value ? carEndingPositionX : carStartingPositionX,
          child: Image.asset(
            TfbAssetStrings.dashboardCar,
            height: carHeight,
            width: carWidth,
          ),
        );
      },
    );
  }
}
