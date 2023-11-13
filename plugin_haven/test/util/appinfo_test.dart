import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_haven/util/app_info.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  group('AppInfo tests', () {
    test('Test AppInfo fields', () async {
      PackageInfo.setMockInitialValues(
        appName: 'appName',
        packageName: 'packageName',
        version: 'version',
        buildNumber: 'buildNumber',
        buildSignature: '',
        installerStore: null,
      );
      final info = await AppInfo.getAppInfo();
      expect(info.appName, 'appName');
      expect(info.packageName, 'packageName');
      expect(info.version, 'version');
      expect(info.buildNumber, 'buildNumber');
    });
  });
}
