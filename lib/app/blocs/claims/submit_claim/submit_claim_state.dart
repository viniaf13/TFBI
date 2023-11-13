part of 'submit_claim_bloc.dart';

abstract class SubmitClaimState extends Equatable {}

class SubmitClaimInitState extends SubmitClaimState {
  @override
  List<Object?> get props => [];
}

class SubmitClaimProcessingState extends SubmitClaimState {
  @override
  List<Object?> get props => [];
}

/// Success or Failure states for fetching a list of policies
class SubmitClaimPolicyListSuccessState extends SubmitClaimState {
  SubmitClaimPolicyListSuccessState({required this.policies});

  final List<PolicySelection?> policies;

  @override
  List<Object?> get props => [policies];
}

class SubmitClaimPolicyListFailureState extends SubmitClaimState {
  SubmitClaimPolicyListFailureState({required this.error});

  final TfbRequestError error;

  @override
  List<Object?> get props => [error];
}

class SubmitPropertyClaimProcessingState extends SubmitClaimState {
  @override
  List<Object?> get props => [];
}

/// Success or Failure states for submitting a property claim
class SubmitPropertyClaimSuccessState extends SubmitClaimState {
  SubmitPropertyClaimSuccessState({
    required this.data,
  });

  final PropertyClaimSubmissionResponse data;

  @override
  List<Object?> get props => [data];
}

class SubmitPropertyClaimFailureState extends SubmitClaimState {
  SubmitPropertyClaimFailureState({required this.error});

  final TfbRequestError error;

  @override
  List<Object?> get props => [error];
}

class SubmitAutoClaimProcessingState extends SubmitClaimState {
  @override
  List<Object?> get props => [];
}

class SubmitAutoClaimSuccessState extends SubmitClaimState {
  SubmitAutoClaimSuccessState({
    required this.data,
  });

  final AutoClaimSubmissionResponse data;

  @override
  List<Object?> get props => [data];
}

class SubmitAutoClaimFailureState extends SubmitClaimState {
  SubmitAutoClaimFailureState({required this.error});

  final TfbRequestError error;

  @override
  List<Object?> get props => [error];
}

/// The selected policy to file a claim against
class SubmitClaimPolicySelectedState extends SubmitClaimState {
  SubmitClaimPolicySelectedState({required this.selectedPolicy});

  final PolicySelection selectedPolicy;

  @override
  List<Object?> get props => [selectedPolicy];
}

/// Success or Failure State for fetching data need for the file a claim form
class SubmitClaimFormInitSuccess extends SubmitClaimState {
  SubmitClaimFormInitSuccess({required this.claimFormData});

  final ClaimFormData claimFormData;

  @override
  List<Object?> get props => [claimFormData];
}

class SubmitClaimFormInitFailure extends SubmitClaimState {
  SubmitClaimFormInitFailure({required this.error});

  final TfbRequestError? error;

  @override
  List<Object?> get props => [error];
}
