import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_email.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_phone.dart';

class AgentContactInfo extends StatelessWidget {
  const AgentContactInfo({required this.agentDetails, super.key});

  final AgentDetails agentDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (agentDetails.hasPhone)
          Row(
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
                phoneNumberForDialing:
                    agentDetails.phoneNumber!.replaceAll('-', '.'),
                phoneNumberForDisplay:
                    agentDetails.phoneNumber!.replaceAll('-', '.'),
                styleForPhoneNumber: context.tfbText.bodyMediumLarge.copyWith(
                  color: TfbBrandColors.blueHigh,
                ),
              ),
            ],
          ),
        if (agentDetails.hasEmail)
          Padding(
            padding: const EdgeInsets.only(top: kSpacingSmall),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: kSpacingSmall,
                  ),
                  child: Image.asset(
                    TfbAssetStrings.mailIcon,
                    width: 16,
                    height: 16,
                  ),
                ),
                TextWithEmail(
                  emailAddress: agentDetails.emailAddress!,
                  styleForEmailAddress:
                      context.tfbText.bodyMediumLarge.copyWith(
                    color: TfbBrandColors.blueHigh,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
