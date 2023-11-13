part of 'submit_claim_bloc.dart';

abstract class SubmitClaimEvent {}

class SubmitClaimInitEvent extends SubmitClaimEvent {}

class SubmitClaimProcessingEvent extends SubmitClaimEvent {}

class SubmitClaimGetPolicyListEvent extends SubmitClaimEvent {}

class SubmitPropertyClaimEvent extends SubmitClaimEvent {
  SubmitPropertyClaimEvent({required this.propertyClaimSubmission});

  final PropertyClaimSubmission propertyClaimSubmission;
}

class SubmitAutoClaimEvent extends SubmitClaimEvent {
  SubmitAutoClaimEvent({required this.autoClaimSubmission});

  final AutoClaimSubmission autoClaimSubmission;
}

class SubmitClaimPolicyListSuccessEvent extends SubmitClaimEvent {
  SubmitClaimPolicyListSuccessEvent({required this.policies});

  final List<PolicySelection> policies;
}

class SubmitClaimPolicyListFailureEvent extends SubmitClaimEvent {
  SubmitClaimPolicyListFailureEvent({required this.error});

  final TfbRequestError error;
}

// A policy to file a claim against has been selected, start claim form init on nav
class ClaimFormInitEvent extends SubmitClaimEvent {
  ClaimFormInitEvent({
    required this.selectedPolicy,
    required this.dateOfLoss,
  });

  final PolicySelection selectedPolicy;
  final String dateOfLoss;
}

class GetVehicleMakesEvent extends SubmitClaimEvent {
  GetVehicleMakesEvent({required this.vehicleYear});

  final String vehicleYear;
}

class GetVehicleModelsEvent extends SubmitClaimEvent {
  GetVehicleModelsEvent({
    required this.vehicleYear,
    required this.vehicleMake,
  });

  final String vehicleYear;
  final String vehicleMake;
}
