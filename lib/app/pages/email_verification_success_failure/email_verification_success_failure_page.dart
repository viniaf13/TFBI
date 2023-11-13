import 'package:flutter/services.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/account_registration_events.dart';
import 'package:txfb_insurance_flutter/app/analytics/tfb_analytics.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_never_pop.dart';

class EmailVerificationSuccessFailurePage extends StatelessWidget {
  const EmailVerificationSuccessFailurePage({this.error, super.key});

  final TfbRequestError? error;

  @override
  Widget build(BuildContext context) {
    final isError = error != null;

    if (isError) {
      TfbAnalytics.instance.track(
        const RegistrationFailureScreenViewEvent(),
      );
    } else {
      TfbAnalytics.instance.track(
        const RegistrationSuccessScreenViewEvent(),
      );
    }

    return TfbNeverPop(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
        body: GradientBackground(
          gradient: LightColors.authenticationBackgroundGradient,
          child: ScrollableViewWithPinnedButton(
            button: TfbFilledButton.primaryTextButton(
              onPressed: context.navigator.goToLoginPage,
              title: context.getLocalizationOf.returnToLoginTitle,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kSpacingExtraLarge,
              ),
              child: ListView(
                children: [
                  Text(
                    isError
                        ? context.getLocalizationOf.somethingWentWrongTitle
                        : context.getLocalizationOf.successTitle,
                    style: context.tfbText.header3.copyWith(
                      color: isError
                          ? TfbBrandColors.redHighest
                          : TfbBrandColors.greenHighest,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: kSpacingMedium),
                    child: Text(
                      isError
                          ? error?.message ??
                              context.getLocalizationOf
                                  .pleaseTryAgainLaterDefaultMessage
                          : context.getLocalizationOf.accountCreatedMessage,
                      style: context.tfbText.bodyRegularLarge,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 100,
                    ),
                    height: 165,
                    child: Image.asset(
                      isError
                          ? TfbAssetStrings.failureCheck
                          : TfbAssetStrings.successCheck,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
