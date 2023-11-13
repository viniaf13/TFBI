// coverage:ignore-file
import 'package:plugin_haven/haven.dart';
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/data/network/service/tfb_analytics_interceptor.dart';

/// TFBClient defines a Type so that all clients are of the same type. This
/// gives us the ability to split up and organize API clients according to the
/// end points and functionality. Additional abstract methods can be added here,
/// if we find that multiple clients share the same methods.
abstract class TfbClient {
  /// Share one authenticated dio instance across all clients that
  /// need authenticated requests.
  ///
  /// By sharing one Dio instance across multiple clients, we only have to set
  /// up the haven proxy service with this one instance.
  static Dio createAuthenticatedDio(String accessToken) {
    final sharedAuthenticatedDio = Dio(
      BaseOptions(
        headers: {'Authorization': 'Bearer $accessToken'},
      ),
    )..interceptors.add(
        TfbAnalyticsInterceptor(),
      );

    if (!HavenProxyService.proxy.isNullOrEmpty) {
      HavenProxyService.addProxyIfSet(sharedAuthenticatedDio);
    }

    return sharedAuthenticatedDio;
  }
}
