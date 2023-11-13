import 'package:txfb_insurance_flutter/app/analytics/events/tfb_analytics_event.dart';

const kBeginClaimEvent = 'file_a_claim';

class FileAClaimEvent extends TfbAnalyticsEvent {
  FileAClaimEvent(
    String screenName,
  ) : super(
          kBeginClaimEvent,
          properties: {
            'screen_name': screenName,
            'cta': 'File a claim',
          },
        );
}
