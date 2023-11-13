import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class NoCachedContent extends StatelessWidget {
  const NoCachedContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: kSpacingMedium,
      ),
      padding: const EdgeInsets.all(
        kSpacingLarge,
      ),
      decoration: BoxDecoration(
        color: TfbBrandColors.white,
        borderRadius: context.radii.defaultRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            context.getLocalizationOf.lookingForYouIdCardHeader,
            style: context.tfbText.header3.copyWith(
              color: TfbBrandColors.blueHighest,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: kSpacingMedium),
            child: Text(
              context.getLocalizationOf.yourCardExplanation,
              style: context.tfbText.bodyRegularLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: kSpacingMedium),
            child: Image.asset(
              TfbAssetStrings.noIdCardImage,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }
}
