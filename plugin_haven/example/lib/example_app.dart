// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plugin_haven/network/address_check_option.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:plugin_haven/remote_config/haven_remote_config_repository.dart';
import 'package:plugin_haven_example/auth/example_auth_repository.dart';
import 'package:plugin_haven_example/environment/example_environment.dart';
import 'package:plugin_haven_example/example_home_screen.dart';
import 'package:plugin_haven_example/remote_config/initialize.dart';
import 'package:plugin_haven_example/splash/example_animated_splash_widget.dart';
import 'package:provider/provider.dart';

enum ExampleAppEnvironmentKeys {
  prod,
  dev,
  qa,
  stage,
}

class ExampleApp extends HavenApp {
  static AppInfo? info;
  static ValueNotifier<HavenRemoteConfigurationRepository?>
      remoteConfigNotifier = ValueNotifier(null);

  const ExampleApp({
    Key? key,
    required super.initConfig,
    required super.appBuilder,
  }) : super(key: key);

  ExampleApp.basic({Key? key})
      : super(
          key: key,
          initConfig: InitConfiguration(
            initialEnvironment: ExampleApp.qa,
            environmentConfigurationFactory: createEnvironmentConfiguration,
            onInitialize: () async {
              print("Initializing Example App...");
              await HavenApp.initialize();
              await Firebase.initializeApp();
              info = await AppInfo.getAppInfo();
            },
          ),
          appBuilder: (context) => ChangeNotifierProvider.value(
            value: remoteConfigNotifier,
            child: const ExampleHomeScreen(),
          ),
        );

  static EnvironmentConfiguration? createEnvironmentConfiguration(
    Environment env,
  ) {
    if (env is ExampleAppEnvironment) {
      switch (env.exampleEnvType) {
        case EnvironmentType.prod:
          return ExampleApp.prodConfig;
        case EnvironmentType.dev:
          return ExampleApp.devConfig;
        case EnvironmentType.qa:
          return ExampleApp.qaConfig;
        case EnvironmentType.stage:
          return ExampleApp.stageConfig;
      }
    }
    return null;
  }

  static Map<ExampleAppEnvironmentKeys, ExampleAppEnvironment> environments = {
    ExampleAppEnvironmentKeys.prod: ExampleAppEnvironment(EnvironmentType.prod),
    ExampleAppEnvironmentKeys.dev: ExampleAppEnvironment(EnvironmentType.dev),
    ExampleAppEnvironmentKeys.qa: ExampleAppEnvironment(EnvironmentType.qa),
    ExampleAppEnvironmentKeys.stage:
        ExampleAppEnvironment(EnvironmentType.stage),
  };

  static ExampleAppEnvironment get prod =>
      environments[ExampleAppEnvironmentKeys.prod]!;
  static ExampleAppEnvironment get dev =>
      environments[ExampleAppEnvironmentKeys.dev]!;
  static ExampleAppEnvironment get stage =>
      environments[ExampleAppEnvironmentKeys.stage]!;
  static ExampleAppEnvironment get qa =>
      environments[ExampleAppEnvironmentKeys.qa]!;

  static List<ConnectionCheckOption> get defaultConnectionCheckOptions => [
        ConnectionCheckOption(
          uri: Uri.parse("https://bottlerocketstudios.com"),
          port: 80,
          timeout: const Duration(seconds: 3),
        )
      ];

  static initRemoteConfig() async {
    HavenRemoteConfigurationRepository config =
        await initializeRemoteConfiguration();
    remoteConfigNotifier.value = config;
  }

  static EnvironmentConfiguration? _prodConfig;
  static EnvironmentConfiguration get prodConfig {
    var authRepository = AutomaticSignInAuthRepository();

    _prodConfig ??= EnvironmentConfiguration(
      authRepository: authRepository,
      splashConfiguration: LottieSplashConfiguration(
        lottieAsset: 'assets/lottie/launch.json',
        backgroundColor: Colors.white,
        waiters: [authRepository],
      ),
      connectionCheckOptions: defaultConnectionCheckOptions,
      onChangeEnvironment: () {
        print('Running prod environment');
        authRepository.signOut();
        ExampleApp.initRemoteConfig();
      },
    );

    return _prodConfig!;
  }

  static EnvironmentConfiguration? _devConfig;
  static EnvironmentConfiguration get devConfig {
    var authRepository = AutomaticSignInAuthRepository();

    _devConfig ??= EnvironmentConfiguration(
      usePreview: bool.fromEnvironment('usePreview', defaultValue: true),
      authRepository: authRepository,
      splashConfiguration: WidgetSplashConfiguration(
        widget: const ExampleAnimatedSplashWidget(),
      ),
      prechangeEnvironmentBuilder: (context) => Expanded(
        child: Container(color: Colors.white),
      ),
      connectionCheckOptions: defaultConnectionCheckOptions,
      onChangeEnvironment: () {
        print('Running dev environment');
        authRepository.signOut();
        ExampleApp.initRemoteConfig();
      },
    );

    return _devConfig!;
  }

  static EnvironmentConfiguration? _stageConfig;
  static EnvironmentConfiguration get stageConfig {
    var authRepository = AutomaticSignInAuthRepository();

    _stageConfig ??= EnvironmentConfiguration(
      authRepository: authRepository,
      splashConfiguration: ImageSplashConfiguration(
        imageAsset: 'assets/images/br.png',
        waiters: [authRepository],
        backgroundColor: Colors.white,
      ),
      connectionCheckOptions: defaultConnectionCheckOptions,
      onChangeEnvironment: () {
        print('Running stage environment');
        ExampleApp.initRemoteConfig();
      },
    );

    return _stageConfig!;
  }

  static EnvironmentConfiguration? _qaConfig;
  static EnvironmentConfiguration get qaConfig {
    var authRepository = AutomaticSignInAuthRepository();

    _qaConfig ??= EnvironmentConfiguration(
      authRepository: authRepository,
      splashConfiguration: WidgetSplashConfiguration(
        widget: Builder(
          builder: (context) {
            context.read<SplashBloc>().add(RemoveSplashWaiterEvent());

            return const Scaffold(
              body: Center(
                child: Text(
                  'QA',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42),
                ),
              ),
            );
          },
        ),
        waiters: [authRepository],
      ),
      connectionCheckOptions: defaultConnectionCheckOptions,
      onChangeEnvironment: () {
        print('Running qa environment');
        authRepository.signOut();
        ExampleApp.initRemoteConfig();
      },
    );

    return _qaConfig!;
  }
}
