import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';

const kAppErrorEvent = 'app_error';

class AppErrorEvent extends TfbAnalyticsEvent {
  AppErrorEvent({required this.error})
      : super(
          kAppErrorEvent,
          properties: {'error_message': error},
        );
  final String error;
}
