import 'package:txfb_insurance_flutter/app/analytics/events/tfb_analytics_event.dart';

const kRoadsideAssistanceEvent = 'roadside_assistance';
const kCtaName = 'Roadside assistance';

class RoadsideAssistanceEvent extends TfbAnalyticsEvent {
  RoadsideAssistanceEvent(
    String screenName,
  ) : super(
          kRoadsideAssistanceEvent,
          properties: {
            'screen_name': screenName,
            'cta': kCtaName,
          },
        );
}
