import 'package:txfb_insurance_flutter/app/analytics/events/tfb_analytics_event.dart';

const kBeginClaimEvent = 'begin_claim';
const kBeginClaimCta = 'Begin claim';

class BeginClaimEvent extends TfbAnalyticsEvent {
  BeginClaimEvent({
    required String policyType,
    required String policyNumber,
    required String dateOfLoss,
    required String screenName,
  }) : super(
          kBeginClaimEvent,
          properties: {
            'policy_type': policyType,
            'policy_number': policyNumber,
            'date_of_loss': dateOfLoss,
            'screen_name': screenName,
            'cta': kBeginClaimCta,
          },
        );
}
