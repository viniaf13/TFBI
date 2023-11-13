import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/file_claim_event.dart';
import 'package:txfb_insurance_flutter/app/analytics/tfb_analytics.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_phone.dart';

class ClaimsHeaderView extends StatelessWidget {
  const ClaimsHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    // card with white background
    // Claims
    // line
    // please note:
    // if you need to
    // file a claim button
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: kSpacingMedium,
            bottom: kSpacingMedium,
          ),
          child: Text(
            context.getLocalizationOf.claimsTitle,
            style: context.tfbText.header3.copyWith(
              color: TfbBrandColors.blueHighest,
            ),
          ),
        ),
        DecoratedBox(
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
                  context.getLocalizationOf.claimsHeaderMessage,
                  style: context.tfbText.bodyRegularSmall.copyWith(
                    color: TfbBrandColors.grayHighest,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: kSpacingSmall),
                ),
                Semantics(
                  label: context.getLocalizationOf.claimsReportingPhoneNumber,
                  child: TextWithPhone(
                    phoneNumberForDisplay:
                        context.getLocalizationOf.claimsHeaderPhoneNumber,
                    phoneNumberForDialing: '800-266-5458',
                    prePhoneNumberString:
                        context.getLocalizationOf.claimsHeaderPhonePrefix,
                    postPhoneNumberString:
                        context.getLocalizationOf.claimsHeaderPhonePostfix,
                    styleForBodyText: context.tfbText.bodyRegularSmall,
                    styleForPhoneNumber: context.tfbText.bodyMediumSmall
                        .copyWith(color: TfbBrandColors.blueHigh),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: kSpacingSmall),
                ),
                TfbFilledButton.primaryTextButton(
                  title: context.getLocalizationOf.claimsFileAClaimCTA,
                  onPressed: () {
                    TfbAnalytics.instance.track(
                      FileAClaimEvent(context.screenName),
                    );
                    context.navigator.pushFileAClaimPage();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
