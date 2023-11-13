part of 'routing_number_validation_cubit.dart';

abstract class RoutingValidationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RoutingValidationInitState extends RoutingValidationState {}

class RoutingValidationProcessingState extends RoutingValidationState {}

class RoutingValidationSuccessState extends RoutingValidationState {
  RoutingValidationSuccessState({required this.response});

  final String response;

  @override
  List<Object?> get props => [response];
}

class RoutingValidationFailureState extends RoutingValidationState {
  RoutingValidationFailureState({required this.error});

  final TfbRequestError error;

  @override
  List<Object?> get props => [error];
}
