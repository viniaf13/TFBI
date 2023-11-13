part of 'registration_resend_cubit.dart';

abstract class RegistrationResendState extends Equatable {
  const RegistrationResendState();

  @override
  List<Object> get props => [];
}

class RegistrationResendInitial extends RegistrationResendState {}

class RegistrationResendProcessing extends RegistrationResendState {}

class RegistrationResendError extends RegistrationResendState {
  const RegistrationResendError(this.error);

  final TfbRequestError error;

  @override
  List<Object> get props => [error];
}

class RegistrationResendSuccess extends RegistrationResendState {}
