import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/domain/models/navigator_route_args.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class AccountVerifyUpdatedEmailPage extends StatelessWidget {
  const AccountVerifyUpdatedEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: TfbAppBar(
        onCancelPressed: () => context.navigator.changeTabBarLocation(
          NavigatorRouteWithoutExtra(route: TfbAppRoutes.account),
        ),
      ),
      body: GradientBackground(
        gradient: LightColors.authenticationBackgroundGradient,
        child: BottomPinnedContent(
          pinnedChild: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: kSpacingLarge,
                left: kSpacingExtraLarge,
                right: kSpacingExtraLarge,
              ),
              child: Text(
                context.getLocalizationOf.updateEmailDidntReceive,
              ),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kSpacingExtraLarge),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Text(
                    context.getLocalizationOf.accountUpdateEmailVerifyTitle,
                    style: context.tfbText.header3.copyWith(
                      color: TfbBrandColors.blueHighest,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: kSpacingMedium),
                    child: Text(
                      context.getLocalizationOf.accountUpdateEmailSubtitle,
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
                        TfbAssetStrings.paperPlane,
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
    );
  }
}
