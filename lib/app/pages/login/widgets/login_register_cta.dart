import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class LoginRegisterCTA extends StatelessWidget {
  const LoginRegisterCTA({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kSpacingExtraLarge),
      child: Center(
        child: GestureDetector(
          onTap: context.navigator.goToRegistrationPage,
          child: RichText(
            text: TextSpan(
              text: '${context.getLocalizationOf.loginRegisterCTA} ',
              style: context.tfbText.bodyMediumLarge.copyWith(
                color: TfbBrandColors.grayHighest,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: context.getLocalizationOf.loginCTALinkText,
                  style: context.tfbText.bodyMediumLarge.copyWith(
                    color: TfbBrandColors.blueHigh,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
