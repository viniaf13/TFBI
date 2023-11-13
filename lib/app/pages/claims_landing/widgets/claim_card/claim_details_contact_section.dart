import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claim_details_widgets.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_email.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_phone.dart';

import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class ClaimDetailsContactSection extends StatelessWidget {
  const ClaimDetailsContactSection({
    required this.claimNumber,
    this.phoneNumber,
    this.emailAddress,
    super.key,
  });

  final String? claimNumber;
  final String? phoneNumber;
  final String? emailAddress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconTextRow(
          imageAssetString: TfbAssetStrings.phoneIcon,
          rowPadding: const EdgeInsets.symmetric(vertical: kSpacingSmall),
          textPadding: const EdgeInsets.only(left: kSpacingSmall),
          childWidget: TextWithPhone(
            phoneNumberForDisplay: phoneNumber?.formatPhoneNumber() ?? '',
            phoneNumberForDialing: phoneNumber ?? '',
            styleForPhoneNumber: context.tfbText.bodyMediumLarge.copyWith(
              color: LightColors.primaryContainer,
            ),
          ),
        ),
        if (!emailAddress.isNullOrEmpty)
          IconTextRow(
            imageAssetString: TfbAssetStrings.mailIcon,
            rowPadding: EdgeInsets.zero,
            textPadding: const EdgeInsets.only(left: kSpacingSmall),
            childWidget: TextWithEmail(
              emailAddress: emailAddress ?? '',
              displayEmailAddress: context.getLocalizationOf.emailClaimsRep,
              styleForEmailAddress: context.tfbText.bodyMediumLarge.copyWith(
                color: LightColors.primaryContainer,
              ),
            ),
          ),
      ],
    );
  }
}
