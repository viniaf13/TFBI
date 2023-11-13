//  Copyright © 2020 Bottle Rocket Studios. All rights reserved.

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:plugin_haven/splash/splash_configuration.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}

class InitialSplashState extends SplashState {
  const InitialSplashState();
  @override
  List<Object> get props => const [];
}

abstract class DisplaySplashState extends SplashState {
  const DisplaySplashState();

  static DisplaySplashState? fromSplashConfiguration(
    SplashConfiguration? config,
  ) {
    if (config is LottieSplashConfiguration) {
      return LottieSplashState(
        config.lottieAsset,
        repeatSplashWhile: config.repeatSplashWhile,
        backgroundColor: config.backgroundColor,
      );
    } else if (config is ImageSplashConfiguration) {
      return ImageSplashState(config.imageAsset, config.backgroundColor);
    } else if (config is WidgetSplashConfiguration) {
      return WidgetSplashState(config.widget);
    }
    return null;
  }
}

class LottieSplashState extends DisplaySplashState {
  const LottieSplashState(
    this.lottieAsset, {
    this.repeatSplashWhile,
    this.backgroundColor,
  });

  final String lottieAsset;
  final bool Function()? repeatSplashWhile;
  final Color? backgroundColor;

  @override
  List<Object> get props => [lottieAsset];
}

class ImageSplashState extends DisplaySplashState {
  const ImageSplashState(this.imageAsset, this.backgroundColor);

  final String imageAsset;
  final Color? backgroundColor;

  @override
  List<Object> get props => [imageAsset];
}

class WidgetSplashState extends DisplaySplashState {
  const WidgetSplashState(this.widget);

  final Widget widget;

  @override
  List<Object> get props => [widget];
}

class DoneSplashState extends SplashState {
  const DoneSplashState();

  @override
  List<Object> get props => [];
}
