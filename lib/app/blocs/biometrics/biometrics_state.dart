part of 'biometrics_bloc.dart';

abstract class BiometricsState extends Equatable {
  const BiometricsState();

  @override
  List<Object> get props => [];
}

class BiometricsInitState extends BiometricsState {}

class BiometricsInitializingState extends BiometricsState {}

class BiometricsReadyState extends BiometricsState {
  const BiometricsReadyState({required this.isEnabled});

  final bool isEnabled;

  @override
  List<Object> get props => [isEnabled];
}

class BiometricsProcessing extends BiometricsState {}

class BiometricsSucceeded extends BiometricsState {
  const BiometricsSucceeded(this.user);

  final TfbUser user;

  @override
  List<Object> get props => [user];
}

class BiometricsFailed extends BiometricsState {
  const BiometricsFailed(this.error, {this.fromTap = false});

  final BiometricsFailureReason error;
  final bool fromTap;

  @override
  List<Object> get props => [error, fromTap];
}
