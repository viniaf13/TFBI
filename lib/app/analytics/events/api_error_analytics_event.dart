import 'package:txfb_insurance_flutter/app/analytics/events/tfb_analytics_event.dart';
import 'package:txfb_insurance_flutter/data/data.dart';

const kApiErrorEvent = 'api_error';

class ApiErrorAnalyticsEvent extends TfbAnalyticsEvent {
  ApiErrorAnalyticsEvent({required this.dioException})
      : super(
          kApiErrorEvent,
          properties: {
            'endpoint': dioException.requestOptions.path,
            'api_error_code': dioException.response?.statusCode.toString() ??
                dioException.type.toString(),
            'api_error_message': dioException.message ?? '',
          },
        );

  final DioException dioException;
}
