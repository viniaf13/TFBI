import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/roadside_assistance_event.dart';
import 'package:txfb_insurance_flutter/app/analytics/tfb_analytics.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/quick_access/widgets/quick_access_card.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';

class QuickAccessRoadsideAssistance extends StatelessWidget {
  const QuickAccessRoadsideAssistance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: QuickAccessCard(
        title: context.getLocalizationOf.roadside,
        onTapped: () {
          TfbAnalytics.instance.track(
            RoadsideAssistanceEvent(context.screenName),
          );
          context.navigator.pushRoadsideAssistancePage();
        },
      ),
    );
  }
}
