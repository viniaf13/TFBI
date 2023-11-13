import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/auto_form_progress_indicator.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/claims_form_progress_indicator.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/property_form_progress_indicator.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class FileAClaimFormHeader extends StatelessWidget {
  const FileAClaimFormHeader({
    required this.policyNumber,
    required this.insuredName,
    required this.keyReporterSection,
    required this.keyLossAndDamageSection,
    required this.reporterSectionStatus,
    required this.lossAndDamageSectionStatus,
    required this.policyType,
    this.keyDriversAndVehiclesSection,
    this.driversAndVehiclesSectionStatus,
    super.key,
  });
  final PolicyType policyType;
  final String policyNumber;
  final String insuredName;
  final GlobalKey keyReporterSection;
  final GlobalKey keyLossAndDamageSection;

  /// Required for policyType TxPersonalAuto
  final GlobalKey? keyDriversAndVehiclesSection;
  final ValueNotifier<ProgressIndicatorStatus> reporterSectionStatus;
  final ValueNotifier<ProgressIndicatorStatus> lossAndDamageSectionStatus;

  /// Required for policyType TxPersonalAuto
  final ValueNotifier<ProgressIndicatorStatus>? driversAndVehiclesSectionStatus;

  @override
  Widget build(
    BuildContext context,
  ) {
    if (policyType == PolicyType.txPersonalAuto) {
      assert(
        keyDriversAndVehiclesSection != null,
        'keyDriversAndVehiclesSection is required for policyType txPersonalAuto',
      );
      assert(
        driversAndVehiclesSectionStatus != null,
        'driversAndVehiclesSectionStatus is required for policyType txPersonalAuto',
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: kSpacingLarge,
          ),
          child: policyType == PolicyType.txPersonalAuto &&
                  keyDriversAndVehiclesSection != null &&
                  driversAndVehiclesSectionStatus != null
              ? AutoFormProgressIndicator(
                  keyReporterSection: keyReporterSection,
                  keyLossAndDamageSection: keyLossAndDamageSection,
                  keyDriversAndVehiclesSection: keyDriversAndVehiclesSection!,
                  reporterSectionStatus: reporterSectionStatus,
                  lossAndDamageSectionStatus: lossAndDamageSectionStatus,
                  driversAndVehiclesSectionStatus:
                      driversAndVehiclesSectionStatus!,
                )
              : PropertyFormProgressIndicator(
                  keyReporterSection: keyReporterSection,
                  keyLossAndDamageSection: keyLossAndDamageSection,
                  reporterSectionStatus: reporterSectionStatus,
                  lossAndDamageSectionStatus: lossAndDamageSectionStatus,
                ),
        ),
        Text(
          context.getLocalizationOf.fileAClaimHeaderPolicyNumber(policyNumber),
          style: context.tfbText.bodyRegularLarge.copyWith(
            color: TfbBrandColors.grayHighest,
          ),
        ),
        Text(
          context.getLocalizationOf.fileAClaimHeaderInsuredName(insuredName),
          style: context.tfbText.bodyRegularLarge.copyWith(
            color: TfbBrandColors.grayHighest,
          ),
        ),
      ],
    );
  }
}
