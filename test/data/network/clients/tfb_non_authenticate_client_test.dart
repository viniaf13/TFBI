import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/data/network/clients/tfb_non_authenticate_client.dart';
import 'package:txfb_insurance_flutter/data/network/service/tfb_analytics_interceptor.dart';

void main() {
  group('TfbDioClient', () {
    late TfbNonAuthenticateClient tfbDioClient;

    setUp(() {
      tfbDioClient = TfbNonAuthenticateClient.instance;
    });

    test('should return a non-null Dio client', () {
      expect(tfbDioClient.client, isNotNull);
    });

    test(
        'should have TfbAnalyticsInterceptor added as an '
        'interceptor', () {
      final bool containsAnalyticsInterceptor =
          tfbDioClient.client.interceptors.any((interceptor) {
        return interceptor is TfbAnalyticsInterceptor;
      });
      expect(containsAnalyticsInterceptor, isTrue);
    });
  });
}
