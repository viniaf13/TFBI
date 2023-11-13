part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object?> get props => const [];
}

class RegistrationFormCompletedEvent extends RegistrationEvent {}

class RegistrationSubmitEvent extends RegistrationEvent {
  const RegistrationSubmitEvent({required this.request});

  final RegistrationRequest request;

  @override
  List<Object?> get props => [request];
}
