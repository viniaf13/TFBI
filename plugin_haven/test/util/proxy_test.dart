import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_haven/util/proxy_settings.dart';

void main() {
  setUp(() {
    ProxySettings.reset();
  });
  group('Haven proxy settings tests', () {
    test('Proxy settings initial values', () {
      expect(ProxySettings.host, null);
      expect(ProxySettings.port, ProxySettings.charlesPort);
      expect(ProxySettings.charlesPort, '8888');
    });
    test('Configure proxy', () {
      const host = '192.0.0.1';
      ProxySettings.setProxy(host);
      expect(ProxySettings.host, host);
      expect(ProxySettings.port, ProxySettings.charlesPort);
      ProxySettings.setProxy(host, port: '1234');
      expect(ProxySettings.port, '1234');
      ProxySettings.reset();
      expect(ProxySettings.host, null);
      expect(ProxySettings.port, ProxySettings.charlesPort);
    });
  });
}
