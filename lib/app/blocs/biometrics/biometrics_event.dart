part of 'biometrics_bloc.dart';

abstract class BiometricsEvent extends Equatable {
  const BiometricsEvent();

  @override
  List<Object> get props => [];
}

class BiometricsInitEvent extends BiometricsEvent {}

class PromptBiometricsIfAvailable extends BiometricsEvent {
  const PromptBiometricsIfAvailable({this.fromTap = false});

  final bool fromTap;
}
