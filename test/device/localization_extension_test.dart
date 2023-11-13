import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';

void main() {
  setUp(TestWidgetsFlutterBinding.ensureInitialized);

  group('Testing Localized Strings', () {
    testWidgets(
        'Given localized strings, when Switch To Dev is requested, then "Switch to dev" should be provided',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('EN', 'US'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Builder(
            builder: (context) =>
                Center(child: Text(context.getLocalizationOf.switchDev)),
          ),
        ),
      );
      expect(find.text('Switch to dev'), findsOneWidget);
    });

    testWidgets(
        'Given localized strings, when Switch To Stage is requested, then "Switch to stage" should be provided',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('EN', 'US'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Builder(
            builder: (context) =>
                Center(child: Text(context.getLocalizationOf.switchStage)),
          ),
        ),
      );

      expect(find.text('Switch to stage'), findsOneWidget);
    });

    testWidgets(
        'Given localized strings, when Switch To Prod is requested, then "Switch to prod" should be provided',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('EN', 'US'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Builder(
            builder: (context) =>
                Center(child: Text(context.getLocalizationOf.switchProd)),
          ),
        ),
      );
      expect(find.text('Switch to prod'), findsOneWidget);
    });

    /// ===================================================================///
    ///                 Fallback Strings Provided                          ///
    /// ===================================================================///
    testWidgets(
        'Given missing or broken context, when localized string is requested, then fallback value is provided',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LocalizationWidget(),
          ),
        ),
      );
      expect(find.text('Switch to prod'), findsOneWidget);
      expect(find.text('Switch to dev'), findsOneWidget);
      expect(find.text('Switch to stage'), findsOneWidget);
      expect(find.text('Okay'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Unauthenticated view'), findsOneWidget);
      expect(find.text('Login with default credentials'), findsOneWidget);
      expect(find.text(AppLocalizationsEn().bioNotSupported), findsOneWidget);
      expect(find.text(AppLocalizationsEn().bioFirstSignIn), findsOneWidget);
      expect(find.text(AppLocalizationsEn().expiredSession), findsOneWidget);
      expect(find.text(AppLocalizationsEn().unknownBioFailure), findsOneWidget);
      expect(find.text(AppLocalizationsEn().yes), findsOneWidget);
      expect(find.text(AppLocalizationsEn().notNow), findsOneWidget);
      expect(find.text(AppLocalizationsEn().enableBio), findsOneWidget);
      expect(
        find.text(AppLocalizationsEn().enableBioSubHeader),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizationsEn().loginOfflineInsuranceCardTitle),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizationsEn().loginUsernamePasswordNotFoundError),
        findsOneWidget,
      );
      expect(find.text(AppLocalizationsEn().submitTitle), findsOneWidget);
      expect(find.text(AppLocalizationsEn().verifyEmailTitle), findsOneWidget);
      expect(
        find.text(AppLocalizationsEn().didntReceiveEmailButton),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizationsEn().didntReceiveEmailLabel),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizationsEn().registerEmailLabel),
        findsOneWidget,
      );
      expect(find.text(AppLocalizationsEn().registerLoginCTA), findsOneWidget);
      expect(
        find.text(AppLocalizationsEn().registerLoginCTAButton),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizationsEn().openEmailButtonTitle),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizationsEn().pleaseTryAgainLaterDefaultMessage),
        findsOneWidget,
      );
      expect(find.text(AppLocalizationsEn().goToSettings), findsOneWidget);
      expect(
        find.text(AppLocalizationsEn().enableBioFromSettings),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizationsEn().enableBioFromSettingsSubHeader),
        findsOneWidget,
      );
      expect(find.text(AppLocalizationsEn().networkError), findsOneWidget);
      expect(
        find.text(AppLocalizationsEn().emailNotVerifiedError),
        findsOneWidget,
      );
    });
  });
}

class LocalizationWidget extends StatelessWidget {
  const LocalizationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final switchProd = context.getLocalizationOf.switchProd;
    final switchDev = context.getLocalizationOf.switchDev;
    final switchStage = context.getLocalizationOf.switchStage;
    final okay = context.getLocalizationOf.okay;
    final cancel = context.getLocalizationOf.cancel;
    final authTitle = context.getLocalizationOf.authenticatedTitle;
    final unauthTitle = context.getLocalizationOf.unauthenticatedTitle;
    final loginTitle = context.getLocalizationOf.loginTitle;
    final bioNotSupported = context.getLocalizationOf.bioNotSupported;
    final bioFirstSignIn = context.getLocalizationOf.bioFirstSignIn;
    final expiredSession = context.getLocalizationOf.expiredSession;
    final unknownBioFailure = context.getLocalizationOf.unknownBioFailure;
    final yes = context.getLocalizationOf.yes;
    final notNow = context.getLocalizationOf.notNow;
    final enableBio = context.getLocalizationOf.enableBio;
    final enableBioSubHeader = context.getLocalizationOf.enableBioSubHeader;
    final loginOfflineInsuranceCardTitle =
        context.getLocalizationOf.loginOfflineInsuranceCardTitle;
    final loginUsernamePasswordNotFoundError =
        context.getLocalizationOf.loginUsernamePasswordNotFoundError;
    final submitTitle = context.getLocalizationOf.submitTitle;
    final verifyEmailTitle = context.getLocalizationOf.verifyEmailTitle;
    final didntReceiveEmailLabel =
        context.getLocalizationOf.didntReceiveEmailLabel;
    final didntReceiveEmailButton =
        context.getLocalizationOf.didntReceiveEmailButton;
    final registerEmailLabel = context.getLocalizationOf.registerEmailLabel;
    final registerLoginCTA = context.getLocalizationOf.registerLoginCTA;
    final registerLoginCTAButton =
        context.getLocalizationOf.registerLoginCTAButton;
    final openEmailButtonTitle = context.getLocalizationOf.openEmailButtonTitle;
    final pleaseTryAgainLaterDefaultMessage =
        context.getLocalizationOf.pleaseTryAgainLaterDefaultMessage;
    final goToSettings = context.getLocalizationOf.goToSettings;
    final enableBioFromSettings =
        context.getLocalizationOf.enableBioFromSettings;
    final enableBioFromSettingsSubHeader =
        context.getLocalizationOf.enableBioFromSettingsSubHeader;
    final networkError = context.getLocalizationOf.networkError;
    final emailNotVerifiedError =
        context.getLocalizationOf.emailNotVerifiedError;

    final List<String> textList = [
      switchDev,
      switchStage,
      switchProd,
      okay,
      cancel,
      authTitle,
      unauthTitle,
      loginTitle,
      bioNotSupported,
      bioFirstSignIn,
      expiredSession,
      unknownBioFailure,
      yes,
      notNow,
      enableBio,
      enableBioFromSettings,
      enableBioFromSettingsSubHeader,
      enableBioSubHeader,
      loginOfflineInsuranceCardTitle,
      loginUsernamePasswordNotFoundError,
      submitTitle,
      verifyEmailTitle,
      didntReceiveEmailLabel,
      didntReceiveEmailButton,
      registerEmailLabel,
      registerLoginCTA,
      registerLoginCTAButton,
      openEmailButtonTitle,
      pleaseTryAgainLaterDefaultMessage,
      goToSettings,
      networkError,
      emailNotVerifiedError,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: textList.map(Text.new).toList(),
    );
  }
}
