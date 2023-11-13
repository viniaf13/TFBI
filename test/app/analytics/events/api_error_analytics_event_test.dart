import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/api_error_analytics_event.dart';

void main() {
  group('ApiErrorAnalyticsEvent', () {
    test(
        'ApiErrorAnalyticsEvent should have correct event name '
        'and properties', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test-endpoint'),
        response: Response(
          statusCode: 404,
          statusMessage: 'Not Found',
          data: {'error': 'Resource not found'},
          requestOptions: RequestOptions(),
        ),
        message: 'Not Found',
      );

      final apiErrorEvent = ApiErrorAnalyticsEvent(dioException: dioException);
      final expectedJson = {
        'endpoint': '/test-endpoint',
        'api_error_code': '404',
        'api_error_message': 'Not Found',
      };

      expect(apiErrorEvent.toJson(), equals(expectedJson));
    });

    test(
        'ApiErrorAnalyticsEvent should have correct event name '
        'and properties when dio response is null', () {
      final dioException = DioException(
        type: DioExceptionType.badResponse,
        requestOptions: RequestOptions(path: '/test-endpoint'),
        message: 'Bad Request',
      );

      final apiErrorEvent = ApiErrorAnalyticsEvent(dioException: dioException);
      final expectedJson = {
        'endpoint': '/test-endpoint',
        'api_error_code': DioExceptionType.badResponse.toString(),
        'api_error_message': 'Bad Request',
      };

      expect(apiErrorEvent.toJson(), equals(expectedJson));
    });
  });
}
