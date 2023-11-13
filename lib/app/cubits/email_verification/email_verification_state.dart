part of 'email_verification_cubit.dart';

abstract class EmailVerificationState extends Equatable {
  const EmailVerificationState();

  @override
  List<Object> get props => [];
}

class EmailVerificationInitial extends EmailVerificationState {}

class EmailVerificationProcessing extends EmailVerificationState {}

class EmailVerificationSuccess extends EmailVerificationState {}

class EmailVerificationError extends EmailVerificationState {
  const EmailVerificationError({required this.error});

  final TfbRequestError error;

  @override
  List<Object> get props => [error];
}
