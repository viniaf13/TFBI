import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/app/pages/insurance_card/insurance_card_page.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/save_insurance_card_switch.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/wallet_button.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class InsuranceCardContent extends StatelessWidget {
  const InsuranceCardContent({
    required this.policySummary,
    required this.policyDetails,
    super.key,
  });

  final PolicySummary policySummary;
  final AutoPolicyDetail policyDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.getLocalizationOf.insuranceCardTitle,
          style: context.tfbText.header3
              .copyWith(color: TfbBrandColors.blueHighest),
        ),
        const SeparatorLine(),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: kSpacingSmall),
          child: WalletButton(policyDetails: policyDetails),
        ),
        TfbFilledButton.secondaryTextButton(
          onPressed: () {
            TfbAnalytics.instance.track(
              ViewIdCardEvent(context.screenName),
            );
            context.navigator.pushInsuranceCardPage(
              params: InsuranceCardPageParameters(
                policySummary: policySummary,
                pdfViewerEventsParameters: PdfViewerEventsParameters(
                  screenName: context.screenName,
                  cta: DocumentEventViewOptions.viewInsuranceCard.value,
                ),
              ),
            );
          },
          title: context.getLocalizationOf.insuranceCardViewCta,
          style: context.tfbText.bodyMediumLarge.copyWith(
            color: TfbBrandColors.blueHighest,
          ),
        ),
        SaveInsuranceCardSwitch(
          policySummary: policySummary,
          policyDetails: policyDetails,
        ),
      ],
    );
  }
}
