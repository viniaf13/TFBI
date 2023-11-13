import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';

const kDashboardScreenViewEvent = 'dashboard_screen_view';

class DashboardScreenViewEvent extends TfbAnalyticsEvent {
  const DashboardScreenViewEvent() : super(kDashboardScreenViewEvent);
}
