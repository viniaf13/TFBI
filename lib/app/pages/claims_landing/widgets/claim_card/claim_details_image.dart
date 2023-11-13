import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class ClaimDetailsImage extends StatelessWidget {
  const ClaimDetailsImage({
    required this.claimImage,
    required this.imageSize,
    super.key,
  });

  /// Temporarily set as a string until TFBI-257 for image work
  final String claimImage;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: kSpacingExtraSmall,
      ),
      child: ClipRRect(
        borderRadius: context.radii.largeRadius,
        child: FittedBox(
          child: Image.asset(
            claimImage,
            width: imageSize,
            height: imageSize,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
