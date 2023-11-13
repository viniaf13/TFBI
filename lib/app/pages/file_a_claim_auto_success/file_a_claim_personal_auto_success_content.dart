import 'package:txfb_insurance_flutter/app/pages/file_a_claim_auto_success/widgets/claim_information_card.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_auto_success/widgets/claim_success_header.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_auto_success/widgets/done_cta.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_animated_app_bar.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_dropshadow_scroll_widget.dart';

class FileAClaimPersonalAutoSuccessContent extends StatelessWidget {
  const FileAClaimPersonalAutoSuccessContent({
    required this.policySelection,
    required this.claimNumber,
    required this.dateOfLoss,
    super.key,
  });

  final PolicySelection policySelection;
  final String claimNumber;
  final String dateOfLoss;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TfbAnimatedAppBar(
        title: Text(
          context.getLocalizationOf.fileAClaimSuccessHeader,
          style: context.tfbText.bodyLightLarge.apply(
            color: TfbBrandColors.blueHighest,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: TfbDropShadowScrollWidget(
        showFooterShadow: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: kSpacingLarge),
                child: ClaimSuccessHeader(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kSpacingSmall),
                child: ClaimInformationCard(
                  policySelection: policySelection,
                  claimNumber: claimNumber,
                  dateOfLoss: dateOfLoss,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kSpacingLarge,
                  vertical: kSpacingMedium,
                ),
                child: Text(
                  context.getLocalizationOf.toCancelAClaimCallRepresentative,
                  style: context.tfbText.bodyMediumSmall.copyWith(
                    color: TfbBrandColors.blueHighest,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const DoneCta(),
    );
  }
}
