import 'package:txfb_insurance_flutter/app/analytics/events/tfb_analytics_event.dart';

const kSubmitClaimEvent = 'submit_claim';
const kCtaName = 'Submit claim';

class SubmitClaim extends TfbAnalyticsEvent {
  SubmitClaim({
    required String policyType,
    required String policyNumber,
    required String dateOfLoss,
    required String timeOfLoss,
    required String screenName,
  }) : super(
          kSubmitClaimEvent,
          properties: {
            'policy_type': policyType,
            'policy_number': policyNumber,
            'date_of_loss': dateOfLoss,
            'time_of_loss': timeOfLoss,
            'screen_name': screenName,
            'cta': kCtaName,
          },
        );
}
