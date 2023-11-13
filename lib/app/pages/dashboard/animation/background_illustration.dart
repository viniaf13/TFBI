import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/widgets/size_reporting_widget.dart';

class BackgroundIllustration extends StatelessWidget {
  const BackgroundIllustration({
    required this.backgroundImage,
    required this.backgroundImageSize,
    required this.isImageLoaded,
    super.key,
  });

  final Image backgroundImage;
  final ValueNotifier<Size> backgroundImageSize;
  final ValueNotifier<bool> isImageLoaded;

  @override
  Widget build(BuildContext context) {
    /// We have to wait until the asset image has been fully loaded before we
    /// are able to measure the height of the background image to position the
    /// car image correctly inside the background
    if (!isImageLoaded.value) {
      addImageLoadCallback(context, () {
        isImageLoaded.value = true;
      });
    }

    return ValueListenableBuilder(
      valueListenable: isImageLoaded,
      builder: (context, value, child) {
        if (value) {
          return SizeReportingWidget(
            child: Align(
              alignment: Alignment.topCenter,
              child: backgroundImage,
            ),
            onSizeChange: (value) => backgroundImageSize.value = value,
          );
        }
        return backgroundImage;
      },
    );
  }

  void addImageLoadCallback(BuildContext context, VoidCallback callback) {
    backgroundImage.image
        .resolve(createLocalImageConfiguration(context))
        .addListener(
      ImageStreamListener((image, synchronousCall) {
        callback();
      }),
    );
  }
}
