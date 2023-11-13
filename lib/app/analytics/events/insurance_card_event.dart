import 'package:txfb_insurance_flutter/app/analytics/events/tfb_analytics_event.dart';

const kiInsuranceCardOfflineToggleActiveEvent =
    'insurance_card_offline_toggle_active';

class InsuranceCardOfflineToggleActiveEvent extends TfbAnalyticsEvent {
  InsuranceCardOfflineToggleActiveEvent(
    String policyType,
    String policyNumber,
    String screenName,
  ) : super(
          kiInsuranceCardOfflineToggleActiveEvent,
          properties: {
            'policy_type': policyType,
            'policy_number': policyNumber,
            'screen_name': screenName,
            'cta': 'Make insurance card available offline',
          },
        );
}

const kViewIdCardEvent = 'view_id_card';

class ViewIdCardEvent extends TfbAnalyticsEvent {
  ViewIdCardEvent(
    String screenName,
  ) : super(
          kViewIdCardEvent,
          properties: {
            'screen_name': screenName,
            'cta': 'View ID card',
          },
        );
}
