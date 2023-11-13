import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_make.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';

abstract class VehicleMakeState {}

class VehicleMakeInitial extends VehicleMakeState {}

class VehicleMakeProcessing extends VehicleMakeState {}

class VehicleMakeSuccess extends VehicleMakeState {
  VehicleMakeSuccess({required this.makes});

  final List<SubmitClaimVehicleMake?> makes;
}

class VehicleMakeFailure extends VehicleMakeState {
  VehicleMakeFailure({required this.error});

  final TfbRequestError error;
}
