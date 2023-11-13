part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
}

class RequestForgotPasswordEvent extends ForgotPasswordEvent {
  const RequestForgotPasswordEvent(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}
