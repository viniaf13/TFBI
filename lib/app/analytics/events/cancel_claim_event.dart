import 'package:txfb_insurance_flutter/app/analytics/events/tfb_analytics_event.dart';

const kCancelClaimEvent = 'cancel_claim';

class CancelClaimEvent extends TfbAnalyticsEvent {
  CancelClaimEvent(
    String policyType,
    String policyNumber,
    String screenName,
  ) : super(
          kCancelClaimEvent,
          properties: {
            'policy_type': policyType,
            'policy_number': policyNumber,
            'screen_name': screenName,
            'cta': 'Yes, cancel',
          },
        );
}
