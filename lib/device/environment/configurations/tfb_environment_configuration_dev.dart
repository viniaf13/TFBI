// coverage:ignore-file
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/app/analytics/mixpanel_project_token.dart';
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/device/environment/configurations/tfb_environment_configuration.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment_dev.dart';
import 'package:txfb_insurance_flutter/device/secure_storage/tfb_secure_storage.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_authentication_client.dart';
import 'package:txfb_insurance_flutter/domain/repositories/storage/tfb_user_storage_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_auth_repository.dart';
import 'package:txfb_insurance_flutter/device/environment/firebase_options.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

class TfbEnvironmentConfigurationDev extends TfbEnvironmentConfiguration {
  @override
  String get apiBaseUrl => kStageApiBaseUrl;

  @override
  TfbAnalyticsConfig get analyticsConfig => TfbAnalyticsConfig(
        firebaseOptions: DefaultFirebaseOptions.currentPlatformWithEnvironment(
          TfbEnvironmentDev(),
        ),
        mixpanelToken: MixpanelProjectToken.staging,
      );

  @override
  TfbAuthRepository? get authRepository => TfbAuthRepository(
        authClient: TfbAuthenticationClient(
          baseUrl: apiBaseUrl,
          dio: unauthenticatedDio,
        ),
        userStorageRepository: TfbUserStorageRepository(
          storage: TfbSecureStorage(storage: const FlutterSecureStorage()),
        ),
      );

  @override
  ThemeData? get lightThemeData => LightThemeData().lightTheme;
}
