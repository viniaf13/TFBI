import 'package:flutter/cupertino.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_haven/haven.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:txfb_insurance_flutter/device/device.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

class MockBuildContext extends Mock implements BuildContext {
  final locale = const Locale('EN', 'US');
  final supportedLocales = AppLocalizations.supportedLocales;
  final localizationsDelegates = AppLocalizations.localizationsDelegates;
}

extension FakingWithBuildContext on MockBuildContext {
  T getEnvironment<T extends Environment?>() {
    final env = TfbEnvironmentStage();
    return env as T;
  }

  String get getBaseUrl => getEnvironment<TfbEnvironment>().apiUrl;

  AppLocalizations get getLocalizationOf =>
      AppLocalizations.of(this) ?? AppLocalizationsEn();
}
