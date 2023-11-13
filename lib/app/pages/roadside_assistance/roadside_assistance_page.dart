import 'package:txfb_insurance_flutter/app/analytics/events/file_claim_event.dart';
import 'package:txfb_insurance_flutter/app/analytics/tfb_analytics.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/constants/spacing.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/mixins/page_properties_mixin.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_animated_app_bar.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_dropshadow_scroll_widget.dart';

import 'package:txfb_insurance_flutter/app/pages/roadside_assistance/widgets/roadside_assistance_details.dart';
import 'package:txfb_insurance_flutter/app/pages/roadside_assistance/widgets/roadside_assistance_header.dart';

class RoadsideAssistancePage extends StatelessWidget with PagePropertiesMixin {
  const RoadsideAssistancePage({super.key});

  @override
  String get screenName => 'Roadside Assistance Screen';

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: TfbAnimatedAppBar(
          showBackButton: true,
          titleString: context.getLocalizationOf.roadsideAssistanceTitle,
        ),
        body: TfbDropShadowScrollWidget(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: kSpacingSmall,
                right: kSpacingSmall,
              ),
              child: Column(
                children: [
                  const RoadsideAssistanceHeader(),
                  const RoadsideAssistanceDetails(),
                  Column(
                    children: [
                      Text(
                        context.getLocalizationOf
                            .roadsideAssistanceTipsInfoInvolvedInAccident,
                        style: context.tfbText.bodyMediumLarge.copyWith(
                          color: TfbBrandColors.grayHighest,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          TfbAnalytics.instance.track(
                            FileAClaimEvent(context.screenName),
                          );
                          context.navigator.pushFileAClaimPage();
                        },
                        child: Text(
                          context.getLocalizationOf
                              .roadsideAssistanceTipsInfoFileAClaim,
                          style: context.tfbText.bodyMediumLarge.copyWith(
                            color: TfbBrandColors.blueHigh,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: kSpacingXxxl,
                        ),
                      ),
                    ],
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
