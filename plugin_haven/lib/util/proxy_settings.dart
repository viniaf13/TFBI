import 'dart:io';

import 'package:dio/dio.dart';
// TBD: Need to find better access to io_adaptor objects
// ignore: implementation_imports
import 'package:dio/src/adapters/io_adapter.dart';

/// Extension to support configuring [Dio] for use with Charles
extension DioProxy on Dio {
  /// Adds proxy to this [Dio] if one is configured
  addProxyIfSet() {
    if (ProxySettings.host != null) {
      addProxyFromIp(ProxySettings.host, port: ProxySettings.port);
    }
  }

  /// Adds platform handler to [Dio] for routing through a proxy
  addProxyFromIp(String? localIp, {String port = '8888'}) {
    HttpClient? configureClient(HttpClient client, String proxy) {
      // Hook into the findProxy callback to set the client's proxy.
      client.findProxy = (url) {
        return 'PROXY $proxy;';
      };
      // This is a workaround to allow Charles to receive
      // SSL payloads.
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    }

    if (localIp != null) {
      String proxy = '$localIp:$port';
      (httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
        return configureClient(client, proxy);
      } as OnHttpClientCreate?;
    }
  }
}

/// Maintains app wide proxy settings (e.g for Charles)
class ProxySettings {
  ProxySettings._();

  static const charlesPort = '8888';
  static String? _proxyHost;
  static String _proxyPort = charlesPort;

  /// Current proxy host if set
  static String? get host => _proxyHost;

  /// Current proxy port. Defaults to '8888' (Charles default port)
  static String get port => _proxyPort;

  /// Update current proxy settings
  static setProxy(String host, {String? port}) {
    _proxyHost = host.isNotEmpty ? host : null;
    _proxyPort = port ?? _proxyPort;
  }

  /// Reset to default settings
  static reset() {
    _proxyHost = null;
    _proxyPort = charlesPort;
  }
}
