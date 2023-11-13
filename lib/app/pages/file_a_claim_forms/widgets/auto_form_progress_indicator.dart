import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/claims_form_progress_indicator.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

class AutoFormProgressIndicator extends StatelessWidget {
  const AutoFormProgressIndicator({
    required this.keyReporterSection,
    required this.keyLossAndDamageSection,
    required this.keyDriversAndVehiclesSection,
    required this.reporterSectionStatus,
    required this.lossAndDamageSectionStatus,
    required this.driversAndVehiclesSectionStatus,
    super.key,
  });

  final GlobalKey keyReporterSection;
  final GlobalKey keyLossAndDamageSection;
  final GlobalKey keyDriversAndVehiclesSection;
  final ValueNotifier<ProgressIndicatorStatus> reporterSectionStatus;
  final ValueNotifier<ProgressIndicatorStatus> lossAndDamageSectionStatus;
  final ValueNotifier<ProgressIndicatorStatus> driversAndVehiclesSectionStatus;

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
        ClaimFormProgressIndicatorStep(
          label: context.getLocalizationOf.claimSectionDriversAndVehicles,
          status: driversAndVehiclesSectionStatus,
          onTap: () => Scrollable.ensureVisible(
            keyDriversAndVehiclesSection.currentContext!,
          ),
        ),
      ],
    );
  }
}
