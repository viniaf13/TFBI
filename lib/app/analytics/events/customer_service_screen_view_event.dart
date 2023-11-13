import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';

const kCustomerServiceScreenViewEvent = 'customer_service_screen_view';

class CustomerServiceScreenViewEvent extends TfbAnalyticsEvent {
  const CustomerServiceScreenViewEvent()
      : super(
          kCustomerServiceScreenViewEvent,
        );
}
