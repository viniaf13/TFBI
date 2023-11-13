// coverage:ignore-file
import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:txfb_insurance_flutter/app/analytics/events/app_error_analytics_event.dart';
import 'package:txfb_insurance_flutter/app/analytics/tfb_analytics.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim/workmanager/import_photo_workmanager.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_authenticated_providers.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_router.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_routes.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_unauthenticated_providers.dart';
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/data/storage/login_remember_me_store.dart';
import 'package:txfb_insurance_flutter/device/camera/camera_file_storage.dart';
import 'package:txfb_insurance_flutter/device/environment/configurations/tfb_environment_configuration_device_preview.dart';
import 'package:txfb_insurance_flutter/device/environment/environment.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment_device_preview.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_auto_policy_document_metadata_repository.dart';
import 'package:txfb_insurance_flutter/shared/constants/environment_keys.dart';
import 'package:txfb_insurance_flutter/shared/utils/tfb_logger.dart';
import 'package:workmanager/workmanager.dart';

class TfbApp extends HavenApp {
  TfbApp.main({super.key})
      : super(
          appBuilder: (context) => MaterialApp.router(
            theme: getEnvConfig(context.getEnvironment<TfbEnvironment>())
                ?.lightThemeData,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: TfbRouter(
              initialLocation: computeInitialRoute(context),
              authenticatedProvidersBuilder: TfbAuthenticatedProviders.new,
              unauthenticatedProvidersBuilder: TfbUnauthenticatedProviders.new,
            ),
            locale: DevicePreview.locale(context),
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(
                // TODO: Ultimately, we should respect the user's preferred font
                // size, but this is a good middle ground for MVP
                textScaleFactor:
                    MediaQuery.textScaleFactorOf(context).clamp(0.7, 1.25),
              ),
              child: DevicePreview.appBuilder(context, child),
            ),
          ),
          initConfig: InitConfiguration(
            initialEnvironment: _computeInitialEnvironment(),
            environmentConfigurationFactory: getEnvConfig,
            onInitialize: () async {
              WidgetsFlutterBinding.ensureInitialized();

              if (const bool.fromEnvironment(kFlutterDriverEnvironmentKey)) {
                enableFlutterDriverExtension();
              }

              await HavenApp.initialize();
              await initializeHive();
              await CameraFileStorage.deleteExpiredPhotos();

              await initializeAnalytics(
                _computeInitialEnvironmentConfig()?.analyticsConfig,
              );
              initializeCrashlytics();

              unawaited(
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                ]),
              );

              await Workmanager().initialize(workManagerDispatcher);
              tz.initializeTimeZones();

              TfbLogger.verbose('App is initialized');
            },
          ),
        );

  static TfbEnvironment _computeInitialEnvironment() =>
      const bool.fromEnvironment(kAppStoreEnvironmentKey)
          ? TfbEnvironmentProduction()
          : TfbEnvironmentDev();

  static TfbEnvironmentConfiguration? _computeInitialEnvironmentConfig() =>
      getEnvConfig(_computeInitialEnvironment());

  static String computeInitialRoute(BuildContext context) =>
      context.read<AuthBloc>().state is AuthSignedIn
          ? TfbAppRoutes.dashboard.relativePath
          : TfbAppRoutes.login.relativePath;

  static Future<void> initializeHive([String? presetHivePath]) async {
    String? hivePath = presetHivePath;
    if (presetHivePath == null) {
      final appDocsDir = await getApplicationDocumentsDirectory();
      hivePath = appDocsDir.path;
    }
    Hive.init(hivePath);
  }

  static Future<void> initializeAnalytics(
    TfbAnalyticsConfig? config,
  ) async {
    // WidgetsFlutterBinding.ensureInitialized already called
    return TfbAnalytics.instance.configure(config);
  }

  static void initializeCrashlytics() {
    if (!kDebugMode) {
      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(
          errorDetails,
        );
        TfbAnalytics.instance.track(
          AppErrorEvent(error: errorDetails.exceptionAsString()),
        );
      };

      /// Pass all uncaught asynchronous errors that aren't handled by the
      /// Flutter framework to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(
          error,
          stack,
          fatal: true,
        );
        TfbAnalytics.instance.track(AppErrorEvent(error: error.toString()));
        return true;
      };
    }
  }

  static Future<void> clearAppData() async {
    try {
      await Future.wait([
        HavenApp.clearAppData(),
        TfbAutoPolicyDocumentMetadataRepository.withDefaultDatabase()
            .deleteAll(),
        (await LoginRememberMeStore.getDefaultSharedPrefs()).clear(),
      ]);
    } catch (e, stack) {
      TfbLogger.warning('Failure when clearing TFB app data', e, stack);
    }
  }

  static TfbEnvironmentConfiguration? getEnvConfig(Environment env) {
    switch (env.runtimeType) {
      case const (TfbEnvironmentDev):
        return development;
      case const (TfbEnvironmentStage):
        return staging;
      case const (TfbEnvironmentProduction):
        return production;
      case const (TfbEnvironmentDevicePreview):
        return stagingDevicePreview;
      default:
        return null;
    }
  }

  static TfbEnvironmentConfiguration development =
      TfbEnvironmentConfigurationDev();
  static TfbEnvironmentConfiguration staging =
      TfbEnvironmentConfigurationStage();
  static TfbEnvironmentConfiguration stagingDevicePreview =
      TfbEnvironmentConfigurationDevicePreview();
  static TfbEnvironmentConfiguration production =
      TfbEnvironmentConfigurationProduction();
}
