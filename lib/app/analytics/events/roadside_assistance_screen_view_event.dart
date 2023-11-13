import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';

const kRoadsideAssistanceScreenViewEvent = 'roadside_assistance_screen_view';

class RoadsideAssistanceScreenViewEvent extends TfbAnalyticsEvent {
  const RoadsideAssistanceScreenViewEvent()
      : super(
          kRoadsideAssistanceScreenViewEvent,
        );
}
