import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/light_colors.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/constants/spacing.dart';
import 'package:txfb_insurance_flutter/shared/constants/tfb_asset_strings.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/widgets/gradient_background.dart';
import 'package:txfb_insurance_flutter/shared/widgets/scrollable_view_with_pinned_button.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_filled_button.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_never_pop.dart';

class AutoPayEnrollmentSuccessPage extends StatelessWidget {
  const AutoPayEnrollmentSuccessPage({required this.policy, super.key});

  final PolicySummary policy;

  @override
  Widget build(BuildContext context) {
    final isManagingAutopay = policy.isAutoPayEnabled;

    final enrollmentSuccessMessage = isManagingAutopay
        ? context.getLocalizationOf.autoPayManageSuccessMessage
        : context.getLocalizationOf.autoPayEnrollSuccessMessage;

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
              onPressed: () => Navigator.of(context)
                ..pop()
                ..pop(),
              title: context.getLocalizationOf.doneCTA,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSpacingLarge),
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
                      enrollmentSuccessMessage,
                      style: context.tfbText.bodyRegularLarge,
                    ),
                  ),
                  Text(
                    context.getLocalizationOf.autoPayEnrollSuccessSubMessage,
                    style: context.tfbText.bodyRegularLarge.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 100),
                    height: 165,
                    child: Image.asset(
                      TfbAssetStrings.successCheck,
                      semanticLabel: 'Success image',
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
