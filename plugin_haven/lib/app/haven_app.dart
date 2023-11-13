//  Copyright © 2020 Bottle Rocket Studios. All rights reserved.

library haven;

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plugin_haven/environment/environment_provider.dart';
import 'package:plugin_haven/haven.dart';
import 'package:plugin_haven/network/network_connectivity_bloc/network_connectivity_bloc.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:plugin_haven/splash/widgets/change_notifier_splash_gate.dart';
import 'package:plugin_haven/util/proxy_settings.dart';

Preferences _preferences = Preferences();

enum HavenPlatform { web, macos, ios, android, windows }

/// Main App
class HavenApp extends StatelessWidget {
  const HavenApp({
    Key? key,
    required this.initConfig,
    required this.appBuilder,
  }) : super(key: key);

  final InitConfiguration initConfig;

  /// This is your main app builder. It is called after the environment has been
  /// configured, after the splash screen has been displayed, and after the auth
  /// bloc has been initialized.
  final Widget Function(BuildContext) appBuilder;

  static bool get isFirstRun => _preferences.isFirstRun;
  static Box get preferences => _preferences.hiveSettings;

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _preferences.init();
  }

  Future<void> run() async {
    await initConfig.onInitialize?.call();
    runApp(this);
  }

  @override
  Widget build(BuildContext context) {
    return EnvironmentProvider(
      defaultEnvironment: initConfig.initialEnvironment,
      child: Builder(
        builder: (context) {
          var environmentConfig =
              initConfig.environmentConfigurationFactory?.call(
            context.getEnvironment(),
          );
          var authRepository = environmentConfig?.authRepository;
          var onChangeEnvironment = environmentConfig?.onChangeEnvironment;
          var envCallbackIsAsync = onChangeEnvironment is PrerunFuture;
          var preChangeEnvBuilder =
              environmentConfig?.prechangeEnvironmentBuilder;

          /// I know they say to use device preview at the [runApp] level, but
          /// it still works here, and allows it to be environment configurable.
          Widget childWidget = DevicePreview(
            enabled: kDebugMode && (environmentConfig?.usePreview ?? false),
            builder: (_) => HavenBlocProviders(
              key: ObjectKey(environmentConfig),
              environmentConfig: environmentConfig,
              authRepository: authRepository,
              child: ChangeNotifierSplashGate(
                splashCompleteBuilder: appBuilder,
                envConfig: environmentConfig,
              ),
            ),
          );

          /// If the environment callback is async, we use a future builder to
          /// wait for the future to complete before building the app.
          ///
          /// Generally, you would want to keep this callback as synchronous as
          /// possible to avoid your UI from flashing. Also, using an async
          /// onChangeEnvironment will render hot reload non-functional as
          /// the FutureBuilder changes the structure of the widget tree at the
          /// root level.
          ///
          /// An optional [environmentBuilder] can be provided to display a
          /// widget while the future is pending.
          if (envCallbackIsAsync) {
            return FutureBuilder(
              future: onChangeEnvironment.call(),
              builder: (context, state) {
                if (state.connectionState != ConnectionState.done &&
                    preChangeEnvBuilder != null) {
                  return preChangeEnvBuilder(context);
                } else if (state.connectionState != ConnectionState.done) {
                  return const SizedBox.shrink();
                }

                return childWidget;
              },
            );
          }

          /// Otherwise, if the callback is synchronous, we just call it and
          /// build the app.
          else {
            environmentConfig?.onChangeEnvironment?.call();
            return childWidget;
          }
        },
      ),
    );
  }

  static HavenPlatform get platform {
    var platform = HavenPlatform.web;
    try {
      if (Platform.isMacOS) {
        // No Google Sign-In plug-in for desktop yet.
        platform = HavenPlatform.macos;
      } else if (Platform.isIOS) {
        platform = HavenPlatform.ios;
      } else if (Platform.isAndroid) {
        platform = HavenPlatform.android;
      } else if (Platform.isWindows) {
        platform = HavenPlatform.windows;
      }
    } catch (error) {
      debugPrint('dart:io Platform not supported for web.');
    }
    return platform;
  }

  static Future<void> configureProxy() async {
    final preferences = Preferences();
    await preferences.init();
    final proxy = await preferences.get('proxy');
    if (proxy != null) {
      debugPrint('Proxy configured to $proxy');
      ProxySettings.setProxy(proxy);
    }
  }

  static Future<void> clearAppData() async {
    try {
      final tempDir = await getTemporaryDirectory();
      if (tempDir.existsSync()) {
        await tempDir.delete(recursive: true);
      }
      final appDir = await getApplicationSupportDirectory();
      if (appDir.existsSync()) {
        await appDir.delete(recursive: true);
      }
    } catch (e) {
      debugPrint('Did not clear previous app data: $e');
    }
  }
}

/// Responsible for providing the [SplashBloc], [NetworkConnectivityBloc],
/// and [AuthBloc] to the widget tree.
class HavenBlocProviders extends StatelessWidget {
  const HavenBlocProviders({
    super.key,
    required this.environmentConfig,
    required this.authRepository,
    required this.child,
  });

  final EnvironmentConfiguration? environmentConfig;
  final AuthRepository? authRepository;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashBloc>(
          create: (context) => SplashBloc(
            environmentConfig?.splashConfiguration,
          ),
        ),
        if (environmentConfig?.connectionCheckOptions?.isNotEmpty ?? false)
          BlocProvider<NetworkConnectivityBloc>(
            create: (context) => NetworkConnectivityBloc(
              connectivityChecker: Connectivity(),
              connectionChecker: InternetConnectionChecker.createInstance(
                checkInterval: environmentConfig?.connectionCheckInterval ??
                    const Duration(seconds: 10),
                addresses: environmentConfig!.connectionCheckOptions!
                    .map(
                      (e) => AddressCheckOptions(
                        hostname: e.uri.host,
                        port: e.port,
                        timeout: e.timeout,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        if (authRepository != null)
          BlocProvider<AuthBloc>(
            lazy: false,
            create: (context) {
              return AuthBloc(authenticator: authRepository!);
            },
          )
      ],
      child: Builder(
        builder: (context) {
          return child;
        },
      ),
    );
  }
}
