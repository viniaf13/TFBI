import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_year.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';

abstract class VehicleYearState {}

class VehicleYearInitial extends VehicleYearState {}

class VehicleYearProcessing extends VehicleYearState {}

class VehicleYearSuccess extends VehicleYearState {
  VehicleYearSuccess({required this.years});

  final List<SubmitClaimVehicleYear?> years;
}

class VehicleYearFailure extends VehicleYearState {
  VehicleYearFailure({required this.error});

  final TfbRequestError error;
}
