import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:plugin_haven/environment/environment_notifier.dart';
import 'package:plugin_haven/haven.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/blocs/biometrics/biometrics_bloc.dart';
import 'package:txfb_insurance_flutter/shared/mixins/page_properties_mixin.dart';
import 'package:txfb_insurance_flutter/device/biometrics/tfb_biometrics.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

/// LocalizationContext provides the Build Context and current Locale
/// that Localizations will need to provide the correct localized string.
/// Use dot notation to access the correct string.
/// Example; "context.getLocalizedOf.appTitle"
extension LocalizationContextExtension on BuildContext {
  AppLocalizations get getLocalizationOf =>
      AppLocalizations.of(this) ?? AppLocalizationsEn();
}

extension EnvironmentUrl on BuildContext {
  String get getBaseUrl => getEnvironment<TfbEnvironment>().apiUrl;
}

extension EnvironmentConfiguration on BuildContext {
  TfbEnvironmentConfiguration? readEnvConfig() => TfbApp.getEnvConfig(
        Provider.of<EnvironmentNotifier>(this, listen: false).environment
            as TfbEnvironment,
      );
}

extension ScreenProperties on BuildContext {
  String get screenName {
    var screenName = 'Unknown Page';

    visitAncestorElements(
      (element) {
        if (element.widget is PagePropertiesMixin) {
          screenName = (element.widget as PagePropertiesMixin).screenName;
        }
        return true;
      },
    );

    return screenName;
  }
}

extension AccessToken on BuildContext {
  String? get tfbUserAccessToken => user?.accessToken;

  String? listenToAccessToken() {
    try {
      final bloc = watch<AuthBloc>();
      final state = bloc.state;
      if (state is AuthSignedIn) {
        final user = state.user;
        if (user is TfbUser) {
          return user.accessToken;
        }
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  TfbUser? get user {
    try {
      final bloc = read<AuthBloc>();
      final state = bloc.state;
      if (state is AuthSignedIn) {
        final user = state.user;
        if (user is TfbUser) {
          return user;
        }
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  String? get getUserMemberNumber {
    try {
      final bloc = read<AuthBloc>();
      final state = bloc.state;
      if (state is AuthSignedIn) {
        final user = state.user;
        if (user is TfbUser) {
          return user.members?.first.memberNumber;
        }
      }
    } catch (error, trace) {
      TfbLogger.exception(
        '[getMemberNumber] Fetch Member Number Failure: $error -- $trace',
      );
    }
    return null;
  }
}

extension TryRead on BuildContext {
  T? tryRead<T>() {
    try {
      final read = Provider.of<T>(this, listen: false);
      return read;
    } catch (_) {}

    return null;
  }
}

extension EnablingBiometricsExtension on BuildContext {
  Future<void> handleEnablingIosBiometrics(
    LoginRequest request, {
    required bool shouldSaveUser,
  }) async {
    if (await TfbBiometrics().isAuthenticated() == true) {
      TfbUserRepository.instance.shouldSaveUser = shouldSaveUser;
      BlocProvider.of<AuthBloc>(this).add(
        AuthSignInEvent(properties: request),
      );
    }
  }

  Future<void> handleEnablingAndroidBiometrics(
    LoginRequest request, {
    required bool shouldSaveUser,
  }) async {
    TfbUserRepository.instance.shouldSaveUser = shouldSaveUser;
    BlocProvider.of<AuthBloc>(this).add(
      AuthSignInEvent(properties: request),
    );
  }

  //if user used biometrics for sign in, shouldSaveUser should be true
  bool get usedBiometrics => TfbUserRepository.instance.shouldSaveUser;
}

extension BiometricsFailureExtension on BuildContext {
  void handleBioFailure(
    BiometricsFailureReason? reason, {
    bool fromTap = false,
  }) {
    switch (reason) {
      case BiometricsFailureReason.noStoredUser:
        if (fromTap) {
          showBiometricsErrorSnackBar(text: getLocalizationOf.bioFirstSignIn);
        }
        break;

      case BiometricsFailureReason.storedUserSessionExpired:
        showBiometricsErrorSnackBar(text: getLocalizationOf.expiredSession);
        break;

      case BiometricsFailureReason.biometricsNotAvailable:
        if (fromTap) {
          showBiometricsErrorSnackBar(text: getLocalizationOf.bioNotSupported);
        }
        break;

      /// Unknown general failures. Copy may need approval
      case BiometricsFailureReason.biometricAuthenticatedFailed:
        showErrorSnackBar(text: getLocalizationOf.unknownBioFailure);
        break;

      case BiometricsFailureReason.unknown:
      default:
        showErrorSnackBar(text: getLocalizationOf.unknownBioFailure);
        break;
    }
  }
}
