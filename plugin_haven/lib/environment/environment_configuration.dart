import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plugin_haven/auth/auth_repository.dart';
import 'package:plugin_haven/network/address_check_option.dart';
import 'package:plugin_haven/splash/splash_configuration.dart';

class EnvironmentConfiguration {
  EnvironmentConfiguration({
    this.splashConfiguration,
    this.themeData,
    this.expectRoute,
    this.authRepository,
    this.onChangeEnvironment,
    this.prechangeEnvironmentBuilder,
    this.connectionCheckOptions,
    this.connectionCheckInterval,
    this.usePreview = false,
  });

  final SplashConfiguration? splashConfiguration;
  final ThemeData? themeData;
  final bool? expectRoute;
  final AuthRepository? authRepository;
  final bool usePreview;

  /// HavenApp is able to monitor network connectivity changes through the
  /// NetworkConnectivityBloc. This is useful for displaying a "no internet"
  /// message to the user.
  ///
  /// To use this feature, provide a list of [ConnectionCheckOption] to your
  /// [EnvironmentConfiguration]. HavenApp will then check each of these URLs
  /// to determine if the device is connected to the internet. If ANY of the
  /// URLs are reachable, the device is considered to be connected.
  final List<ConnectionCheckOption>? connectionCheckOptions;

  /// How often the connection check occurs, regardless of the connectivity status.
  /// Defaults to 10 seconds.
  final Duration? connectionCheckInterval;

  /// The builder that is called after the environment has been changed but
  /// before the [onChangeEnvironment] future has completed.
  ///
  /// If the [onChangeEnvironment] future is null or completes synchronously,
  /// this builder will not be called.
  final Widget Function(BuildContext)? prechangeEnvironmentBuilder;

  final FutureOr<void> Function()? onChangeEnvironment;
}
