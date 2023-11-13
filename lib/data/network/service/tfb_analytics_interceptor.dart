import 'package:txfb_insurance_flutter/app/analytics/events/api_error_analytics_event.dart';
import 'package:txfb_insurance_flutter/app/analytics/tfb_analytics.dart';
import 'package:txfb_insurance_flutter/data/data.dart';

class TfbAnalyticsInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    TfbAnalytics.instance.track(
      ApiErrorAnalyticsEvent(dioException: err),
    );

    handler.next(err);
  }
}
