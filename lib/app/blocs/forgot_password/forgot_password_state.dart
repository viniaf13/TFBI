part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordRequestProcessing extends ForgotPasswordState {}

class ForgotPasswordRequestError extends ForgotPasswordState {
  const ForgotPasswordRequestError({required this.error});

  final TfbRequestError error;
}

class ForgotPasswordRequestSuccess extends ForgotPasswordState {
  const ForgotPasswordRequestSuccess(this.email);

  final String email;
}
