part of 'auto_policy_cubit.dart';

abstract class AutoPolicyState extends Equatable {
  const AutoPolicyState();

  @override
  List<Object> get props => [];
}

class AutoPolicyInitial extends AutoPolicyState {}

class AutoPolicyProcessing extends AutoPolicyState {}

class AutoPolicySuccess extends AutoPolicyState {
  const AutoPolicySuccess({
    required this.autoPolicyDetail,
  });

  final AutoPolicyDetail autoPolicyDetail;

  @override
  List<Object> get props => [autoPolicyDetail];
}

class AutoPolicyFailure extends AutoPolicyState {
  const AutoPolicyFailure({
    required this.error,
  });

  final TfbRequestError error;

  @override
  List<Object> get props => [error];
}
