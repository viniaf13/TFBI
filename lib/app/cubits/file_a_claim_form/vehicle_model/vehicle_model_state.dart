import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_model.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';

abstract class VehicleModelState {}

class VehicleModelInitial extends VehicleModelState {}

class VehicleModelProcessing extends VehicleModelState {}

class VehicleModelSuccess extends VehicleModelState {
  VehicleModelSuccess({required this.models});

  final List<VehicleModelResponse?> models;
}

class VehicleModelFailure extends VehicleModelState {
  VehicleModelFailure({required this.error});

  final TfbRequestError error;
}
