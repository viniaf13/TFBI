//  Copyright © 2020 Bottle Rocket Studios. All rights reserved.

import 'package:equatable/equatable.dart';
import 'package:plugin_haven/splash/splash_configuration.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => const [];
}

class DisplaySplashEvent extends SplashEvent {
  const DisplaySplashEvent(this.splashConfiguration);
  final SplashConfiguration splashConfiguration;

  @override
  List<Object> get props => [splashConfiguration];
}

class RemoveSplashWaiterEvent extends SplashEvent {}

class AddSplashWaiterEvent extends SplashEvent {}

class ForceHideSplashEvent extends SplashEvent {}
