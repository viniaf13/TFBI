import 'package:flutter/services.dart';
import 'package:txfb_insurance_flutter/app/pages/forgot_password_verify_email/widgets/forgot_password_request_listener_alert.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

import 'package:txfb_insurance_flutter/app/pages/forgot_password_verify_email/widgets/forgot_password_bottom_content.dart';

class ForgotPasswordVerifyEmailPage extends StatelessWidget {
  const ForgotPasswordVerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          CancelAppBarAction(
            onPress: () => context.navigator.goToLoginPage(),
          ),
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: GradientBackground(
        gradient: LightColors.authenticationBackgroundGradient,
        child: ScrollableViewWithPinnedButton(
          button: const ForgotPasswordBottomContent(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: ListView(
              children: [
                const ForgotPasswordRequestListenerAlert(),
                Text(
                  context.getLocalizationOf.verifyEmailPageTitle,
                  style: context.tfbText.header3.copyWith(
                    color: TfbBrandColors.blueHighest,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: kSpacingMedium),
                  child: Text(
                    context.getLocalizationOf.checkEmailVerify,
                    style: context.tfbText.bodyRegularLarge,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: kSpacingExtraLarge * 2.5,
                  ),
                  height: 165,
                  child: Image.asset(TfbAssetStrings.paperPlane),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
