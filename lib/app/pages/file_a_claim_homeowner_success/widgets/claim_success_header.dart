import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/constants/spacing.dart';
import 'package:txfb_insurance_flutter/shared/constants/tfb_asset_strings.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

class ClaimSuccessHeader extends StatelessWidget {
  const ClaimSuccessHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.getLocalizationOf.fileAClaimSuccessHeader,
          style: context.tfbText.header3.copyWith(
            color: TfbBrandColors.blueHighest,
          ),
        ),
        const SizedBox(height: kSpacingMedium),
        Text(
          context.getLocalizationOf.yourClaimHasBeenSubmittedSuccessfully,
          style: context.tfbText.bodyRegularLarge,
        ),
        const SizedBox(height: kSpacingXxl),
        Center(
          widthFactor: double.infinity,
          child: Image.asset(
            height: 107,
            TfbAssetStrings.claimsSuccessIcon,
          ),
        ),
        const SizedBox(height: kSpacingXxl),
        Text.rich(
          TextSpan(
            style: context.tfbText.bodyRegularSmall,
            children: <TextSpan>[
              TextSpan(
                text: context
                    .getLocalizationOf.pleaseKeepTheAboveConfirmationNumber,
              ),
              TextSpan(
                text: context.getLocalizationOf.itIsNotYouClaimNumber,
                style: context.tfbText.bodyBoldSmall,
              ),
              TextSpan(
                text: context.getLocalizationOf.yourClaimNumberWillBeProvided,
              ),
            ],
          ),
        ),
        const SizedBox(height: kSpacingSmall),
        Text(
          context.getLocalizationOf.pleaseNoteYourClaimWillBeVisibleInApp,
          style: context.tfbText.bodyRegularSmall,
        ),
        const SizedBox(height: kSpacingLarge),
      ],
    );
  }
}
