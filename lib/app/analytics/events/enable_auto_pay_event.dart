import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';

const kEnableAutoPayEvent = 'enable_auto_pay';
const kEnableAutoPayCta = 'Enable auto pay';

class EnableAutoPayEvent extends TfbAnalyticsEvent {
  EnableAutoPayEvent({
    required String policyType,
    required String policyNumber,
    required String screenName,
  }) : super(
          kEnableAutoPayEvent,
          properties: {
            'policy_type': policyType,
            'policy_number': policyNumber,
            'screen_name': screenName,
            'cta': kEnableAutoPayCta,
          },
        );
}
