import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/constants/spacing.dart';
import 'package:txfb_insurance_flutter/shared/constants/strings.dart';
import 'package:txfb_insurance_flutter/shared/constants/tfb_asset_strings.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/widgets/separator_line.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_phone.dart';

class RoadsideAssistanceHeader extends StatelessWidget {
  const RoadsideAssistanceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: context.radii.defaultRadius,
        ),
        color: TfbBrandColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(kSpacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.getLocalizationOf.roadsideAssistanceTitle,
              style: context.tfbText.header3.copyWith(
                color: TfbBrandColors.blueHighest,
              ),
            ),
            const SeparatorLine(),
            Image.asset(
              width: 106,
              height: 48,
              TfbAssetStrings.towTruckIcon,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: kSpacingSmall),
            ),
            Text(
              context.getLocalizationOf.roadsideAssistanceTipsInfoHeaderMessage,
              style: context.tfbText.bodyMediumSmall.copyWith(
                color: TfbBrandColors.grayHighest,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: kSpacingMedium),
            ),
            Text(
              context
                  .getLocalizationOf.roadsideAssistanceTipsInfoSubHeaderMessage,
              style: context.tfbText.bodyBoldSmall.copyWith(
                color: TfbBrandColors.grayHighest,
              ),
            ),
            const SeparatorLine(),
            Text(
              context.getLocalizationOf
                  .roadsideAssistanceTipsInfoCallForAssistance,
              style: context.tfbText.bodyMediumLarge.copyWith(
                color: TfbBrandColors.grayHighest,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: kSpacingSmall),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: kSpacingSmall,
                    ),
                    child: Image.asset(
                      TfbAssetStrings.phoneIcon,
                      width: 16,
                      height: 16,
                    ),
                  ),
                  TextWithPhone(
                    phoneNumberForDisplay: kRequestAssistancePhoneDisplay,
                    phoneNumberForDialing: kRequestAssistancePhoneDialing,
                    styleForPhoneNumber:
                        context.tfbText.bodyMediumLarge.copyWith(
                      color: TfbBrandColors.blueHigh,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: kSpacingSmall),
            ),
            Text(
              context.getLocalizationOf
                  .roadsideAssistanceTipsInfoRequestServiceOnline,
              style: context.tfbText.bodyMediumLarge.copyWith(
                color: TfbBrandColors.grayHighest,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: kSpacingSmall),
              child: Row(
                children: [
                  Image.asset(
                    width: 16,
                    height: 16,
                    TfbAssetStrings.externalLinkIcon,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      right: kSpacingSmall,
                    ),
                  ),
                  Semantics(
                    button: true,
                    label: kRequestAssistanceServiceOnline,
                    child: GestureDetector(
                      onTap: () {
                        context.navigator.pushToWebViewerPage(
                          Uri.parse(kRequestAssistanceServiceOnline),
                        );
                      },
                      child: Text(
                        kRequestAssistanceServiceOnline,
                        style: context.tfbText.bodyMediumLarge.copyWith(
                          color: TfbBrandColors.blueHigh,
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
    );
  }
}
