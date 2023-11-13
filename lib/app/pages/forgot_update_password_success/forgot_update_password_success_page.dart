import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_never_pop.dart';

class ForgotUpdatePasswordSuccessPage extends StatelessWidget {
  const ForgotUpdatePasswordSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TfbNeverPop(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: TfbAppBar(
          onCancelPressed: Navigator.of(context).pop,
        ),
        body: GradientBackground(
          gradient: LightColors.authenticationBackgroundGradient,
          child: ScrollableViewWithPinnedButton(
            button: TfbFilledButton.primaryTextButton(
              onPressed: context.navigator.goToLoginPage,
              title: context.getLocalizationOf.returnToLoginTitle,
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Text(
                      context.getLocalizationOf.successTitle,
                      style: context.tfbText.header3.copyWith(
                        color: TfbBrandColors.greenHighest,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: kSpacingMedium),
                      child: Text(
                        context.getLocalizationOf.passwordUpdatedSubtitle,
                        style: context.tfbText.bodyRegularLarge,
                      ),
                    ),
                    Center(
                      child: Container(
                        // TFBI-459: Replace with dynamic spacing
                        margin: const EdgeInsets.only(
                          top: kSpacingExtraLarge * 3,
                        ),
                        child: Image.asset(
                          TfbAssetStrings.successCheck,
                          width: 160,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
