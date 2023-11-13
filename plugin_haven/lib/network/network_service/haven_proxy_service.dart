import 'dart:io';

import 'package:dio/io.dart';
import 'package:dio/dio.dart';

String? _proxy;

class HavenProxyService {
  const HavenProxyService();

  static String? get proxy => _proxy;
  static void setProxy(String proxy) {
    _proxy = proxy.isNotEmpty ? proxy : null;
  }

  static void addProxyIfSet(Dio dio) {
    if (_proxy != null) {
      addProxyFromIp(_proxy, dio);
    }
  }

  static void addProxyFromIp(String? localIp, Dio dio) {
    if (localIp != null) {
      final proxy = '$localIp:8888';
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (client) {
        // Hook into the findProxy callback to set the client's proxy.
        client.findProxy = (url) {
          return 'PROXY $proxy;';
        };
        // This is a workaround to allow Charles to receive
        // SSL payloads.
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }
}
