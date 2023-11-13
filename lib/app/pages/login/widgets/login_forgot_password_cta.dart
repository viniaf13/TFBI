import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class LoginForgotPasswordCTA extends StatelessWidget {
  const LoginForgotPasswordCTA({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.navigator.goToForgotPasswordPage,
      child: Padding(
        padding: const EdgeInsets.only(
          top: kSpacingExtraSmall,
          bottom: kSpacingLarge,
        ),
        child: Text(
          context.getLocalizationOf.loginForgotPassword,
          style: context.tfbText.bodyMediumSmall
              .copyWith(color: TfbBrandColors.blueHigh),
        ),
      ),
    );
  }
}
