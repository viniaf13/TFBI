import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/claims_form_progress_indicator.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

class PropertyFormProgressIndicator extends StatelessWidget {
  const PropertyFormProgressIndicator({
    required this.keyReporterSection,
    required this.keyLossAndDamageSection,
    required this.reporterSectionStatus,
    required this.lossAndDamageSectionStatus,
    super.key,
  });

  final GlobalKey keyReporterSection;
  final GlobalKey keyLossAndDamageSection;
  final ValueNotifier<ProgressIndicatorStatus> reporterSectionStatus;
  final ValueNotifier<ProgressIndicatorStatus> lossAndDamageSectionStatus;

  @override
  Widget build(BuildContext context) {
    return ClaimsFormProgressIndicator(
      steps: [
        ClaimFormProgressIndicatorStep(
          label: context.getLocalizationOf.claimSectionReporter,
          status: reporterSectionStatus,
          onTap: () => Scrollable.ensureVisible(
            keyReporterSection.currentContext!,
          ),
        ),
        ClaimFormProgressIndicatorStep(
          label: context.getLocalizationOf.claimSectionLossAndDamage,
          status: lossAndDamageSectionStatus,
          onTap: () => Scrollable.ensureVisible(
            keyLossAndDamageSection.currentContext!,
          ),
        ),
      ],
    );
  }
}
