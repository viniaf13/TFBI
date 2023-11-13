import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';

const kMakeMembershipPaymentEvent = 'make_membership_payment';

class MakeMembershipPaymentEvent extends TfbAnalyticsEvent {
  MakeMembershipPaymentEvent(
    String screenName,
  ) : super(
          kMakeMembershipPaymentEvent,
          properties: {
            'screen_name': screenName,
            'cta': 'Make membership payment',
          },
        );
}
