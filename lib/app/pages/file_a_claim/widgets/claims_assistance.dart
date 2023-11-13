import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_phone.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

class ClaimsAssistance extends StatelessWidget {
  const ClaimsAssistance({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: context.radii.defaultRadius,
        ),
        color: TfbBrandColors.white,
      ),
      child: Container(
        padding: const EdgeInsets.all(kSpacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.getLocalizationOf.claimsAssistanceTitle,
              style: context.tfbText.header3.copyWith(
                color: TfbBrandColors.blueHighest,
              ),
            ),
            const SeparatorLine(),
            Text(
              context.getLocalizationOf.claimsAssistanceMessage,
              style: context.tfbText.bodyMediumLarge.copyWith(
                color: TfbBrandColors.grayHighest,
              ),
            ),
            const SizedBox(height: kSpacingSmall),
            Row(
              children: [
                Image.asset(
                  TfbAssetStrings.phoneIcon,
                  height: 16,
                  width: 16,
                ),
                const SizedBox(width: kSpacingSmall),
                TextWithPhone(
                  phoneNumberForDisplay: '1.800.266.5458',
                  phoneNumberForDialing: '800-266-5458',
                  styleForPhoneNumber: context.tfbText.bodyMediumLarge.copyWith(
                    color: TfbBrandColors.blueHigh,
                  ),
                ),
              ],
            ),
            const SizedBox(height: kSpacingMedium),
            Text(
              context.getLocalizationOf.roadsideAssistanceTitle,
              style: context.tfbText.bodyMediumLarge.copyWith(
                color: TfbBrandColors.grayHighest,
              ),
            ),
            const SizedBox(height: kSpacingSmall),
            Row(
              children: [
                Image.asset(
                  TfbAssetStrings.phoneIcon,
                  height: 16,
                  width: 16,
                ),
                const SizedBox(width: kSpacingSmall),
                TextWithPhone(
                  phoneNumberForDisplay: '1.833.832.7623',
                  phoneNumberForDialing: '833-832-7623',
                  styleForPhoneNumber: context.tfbText.bodyMediumLarge.copyWith(
                    color: TfbBrandColors.blueHigh,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
