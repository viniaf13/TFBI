import 'package:flutter/services.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/domain/models/navigator_route_args.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_never_pop.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class ChangePasswordSuccessPage extends StatelessWidget {
  const ChangePasswordSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              onPressed: () => context.navigator.changeTabBarLocation(
                NavigatorRouteWithoutExtra(route: TfbAppRoutes.account),
              ),
              title: context.getLocalizationOf.doneCTA,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kSpacingExtraLarge,
              ),
              child: ListView(
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
                      context.getLocalizationOf.changePasswordSuccessMessage,
                      style: context.tfbText.bodyRegularLarge,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 100,
                    ),
                    height: 165,
                    child: Image.asset(
                      TfbAssetStrings.successCheck,
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
