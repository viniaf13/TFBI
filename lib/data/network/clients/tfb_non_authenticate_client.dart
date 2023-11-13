import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/data/network/service/tfb_analytics_interceptor.dart';

/// TfbNonAuthenticateClient defines a generic shared Dio instance that should
/// be used across the app when a non authenticate client is required
class TfbNonAuthenticateClient {
  TfbNonAuthenticateClient._() {
    _dio = Dio();
    _dio.interceptors.add(TfbAnalyticsInterceptor());
  }

  late final Dio _dio;

  static final TfbNonAuthenticateClient instance = TfbNonAuthenticateClient._();

  Dio get client => _dio;
}
