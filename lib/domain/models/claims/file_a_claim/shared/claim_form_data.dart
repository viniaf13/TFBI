// coverage:ignore-file
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_year.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/enum/submit_claim_us_states.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/loss_types.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_county.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_phone_types.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_reporter_types.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/auto_policy_detail.dart';

import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/policy_details/policy_details.dart';

class ClaimFormData {
  const ClaimFormData({
    required this.contactType,
    required this.reporterType,
    required this.typeOfLoss,
    required this.county,
    required this.state,
    required this.insuredDrivers,
    required this.insuredVehicles,
    required this.vehicleYears,
    required this.policyDetails,
  });
  final List<SubmitClaimPhoneTypes?> contactType;
  final List<SubmitClaimReporterTypes?> reporterType;
  final List<LossTypes?> typeOfLoss;
  final List<SubmitClaimCounty?> county;
  final List<SubmitClaimUsStates?> state;
  final List<Driver?> insuredDrivers;
  final List<Vehicle?> insuredVehicles;
  final List<SubmitClaimVehicleYear?> vehicleYears;
  final PolicyDetails? policyDetails;

  @override
  String toString() {
    return 'Claim Form Data\n'
        'Phone Types: ${contactType.toString()}\n'
        'Reporter Types: ${reporterType.toString()}\n'
        'Loss Types: ${typeOfLoss.toString()}\n'
        'Counties: ${county.toString()}\n'
        'States: ${state.toString()}\n'
        'Drivers: ${insuredDrivers.toString()}\n'
        'Vehicles: ${insuredVehicles.toString()}\n'
        'Vehicle Years: ${vehicleYears.toString()}';
  }
}
