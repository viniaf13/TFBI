part of 'forgot_password_verify_cubit.dart';

abstract class ForgotPasswordVerifyState extends Equatable {
  const ForgotPasswordVerifyState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordVerifyInitial extends ForgotPasswordVerifyState {}

class ForgotPasswordVerifyProcessing extends ForgotPasswordVerifyState {}

class ForgotPasswordVerifySuccess extends ForgotPasswordVerifyState {}

class ForgotPasswordVerifyFailure extends ForgotPasswordVerifyState {
  const ForgotPasswordVerifyFailure({
    required this.error,
  });

  final TfbRequestError error;

  @override
  List<Object> get props => [error];
}
