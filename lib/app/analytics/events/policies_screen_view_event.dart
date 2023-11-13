import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';

const kPoliciesScreenViewEvent = 'policies_screen_view';

class PoliciesScreenViewEvent extends TfbAnalyticsEvent {
  const PoliciesScreenViewEvent()
      : super(
          kPoliciesScreenViewEvent,
        );
}

const kPoliciesDetailsScreenViewEvent = 'policies_details_screen_view';

class PoliciesDetailsScreenViewEvent extends TfbAnalyticsEvent {
  const PoliciesDetailsScreenViewEvent()
      : super(
          kPoliciesDetailsScreenViewEvent,
        );
}
