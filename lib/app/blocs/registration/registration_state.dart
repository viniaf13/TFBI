part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();
}

class RegistrationInitState extends RegistrationState {
  const RegistrationInitState();

  @override
  List<Object?> get props => [];
}

class RegistrationShouldSubmitState extends RegistrationState {
  @override
  List<Object?> get props => [];
}

class RegistrationProcessingState extends RegistrationState {
  @override
  List<Object?> get props => [];
}

class RegistrationSuccessState extends RegistrationState {
  const RegistrationSuccessState({required this.request});

  final RegistrationRequest request;

  @override
  List<Object?> get props => [];
}

class RegistrationFailureState extends RegistrationState {
  const RegistrationFailureState({required this.error});

  final TfbRequestError error;

  @override
  List<Object?> get props => [error];
}
