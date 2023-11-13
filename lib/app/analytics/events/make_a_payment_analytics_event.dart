import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';

const kMakeAPaymentEvent = 'make_a_payment';

class MakeAPaymentEvent extends TfbAnalyticsEvent {
  MakeAPaymentEvent({
    required this.policyType,
    required this.policyNumber,
    required this.screenName,
  }) : super(
          kMakeAPaymentEvent,
          properties: {
            'policy_number': policyNumber,
            'policy_type': policyType,
            'screen_name': screenName,
          },
        );
  final String policyType;
  final String policyNumber;
  final String screenName;
}
