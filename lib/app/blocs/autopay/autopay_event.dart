part of 'autopay_bloc.dart';

sealed class AutopayEvent extends Equatable {
  const AutopayEvent();

  @override
  List<Object> get props => [];
}

class ResetAutopayBloc extends AutopayEvent {}

class EnrollInAutopay extends AutopayEvent {
  const EnrollInAutopay({
    required this.policy,
    required this.form,
    required this.user,
  });

  final PolicySummary policy;
  final AutopayFormState form;
  final TfbUser user;
}

class UpdateAutopay extends AutopayEvent {
  const UpdateAutopay({
    required this.policy,
    required this.form,
    required this.user,
  });

  final PolicySummary policy;
  final AutopayFormState form;
  final TfbUser user;
}

class CancelledAutopayEnrollment extends AutopayEvent {}

class DisenrollInAutopay extends AutopayEvent {
  const DisenrollInAutopay({required this.policy, required this.user});

  final PolicySummary policy;
  final TfbUser user;
}
