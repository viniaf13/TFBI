import 'package:txfb_insurance_flutter/app/analytics/events/tfb_analytics_event.dart';

const kAppFirstOpenEvent = 'app_first_open';

class AppFirstOpen extends TfbAnalyticsEvent {
  const AppFirstOpen() : super(kAppFirstOpenEvent);
}
