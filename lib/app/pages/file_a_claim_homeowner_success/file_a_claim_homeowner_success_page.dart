import 'package:txfb_insurance_flutter/app/pages/file_a_claim_homeowner_success/widgets/done_cta.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_animated_app_bar.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_dropshadow_scroll_widget.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

import 'package:txfb_insurance_flutter/app/pages/file_a_claim_homeowner_success/widgets/claim_information_card.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_homeowner_success/widgets/claim_success_header.dart';

class FileAClaimHomeownerSuccessPage extends StatelessWidget {
  const FileAClaimHomeownerSuccessPage({
    required this.confirmationNumber,
    required this.policy,
    required this.dateOfLoss,
    super.key,
  });

  final String confirmationNumber;
  final PolicySelection policy;
  final String dateOfLoss;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TfbAnimatedAppBar(
        titleString: context.getLocalizationOf.fileAClaimSuccessHeader,
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
                  confirmationNumber: confirmationNumber,
                  policy: policy,
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
