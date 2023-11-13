import 'package:flutter/material.dart';

abstract class SplashConfiguration {
  final Color? backgroundColor;

  /// The list of ChangeNotifiers that will be waited on before hiding
  /// the splash screen.
  final List<ChangeNotifier?>? waiters;

  SplashConfiguration(this.backgroundColor, this.waiters);
}

class LottieSplashConfiguration extends SplashConfiguration {
  static bool _defaultRepeatWhile() => false;

  LottieSplashConfiguration({
    required this.lottieAsset,
    this.repeatSplashWhile = _defaultRepeatWhile,
    Color? backgroundColor,
    final List<ChangeNotifier?>? waiters,
  }) : super(backgroundColor, waiters);

  final String lottieAsset;
  final bool Function() repeatSplashWhile;
}

class ImageSplashConfiguration extends SplashConfiguration {
  ImageSplashConfiguration({
    required this.imageAsset,
    Color? backgroundColor,
    final List<ChangeNotifier?>? waiters,
  }) : super(backgroundColor, waiters);

  final String imageAsset;
}

class WidgetSplashConfiguration extends SplashConfiguration {
  WidgetSplashConfiguration({
    required this.widget,
    Color? backgroundColor,
    final List<ChangeNotifier?>? waiters,
  }) : super(backgroundColor, waiters);

  final Widget widget;
}
