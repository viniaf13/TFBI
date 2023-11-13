//  Copyright © 2022 Bottle Rocket Studios. All rights reserved.

import 'package:package_info_plus/package_info_plus.dart';

/// Wraps and maintains package_info_plus for Haven projects.
class AppInfo {
  AppInfo({
    required this.appName,
    required this.packageName,
    required this.version,
    required this.buildNumber,
  });

  /// `CFBundleDisplayName` on iOS, `application/label` on Android
  final String appName;

  /// `bundleIdentifier` on iOS, `getPackageName` on Android.
  final String packageName;

  /// `CFBundleShortVersionString` on iOS, `versionName` on Android.
  final String version;

  /// The build number. `CFBundleVersion` on iOS, `versionCode` on Android.
  final String buildNumber;

  /// Retrieve underlying platform build info.
  static Future<AppInfo> getAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return AppInfo(
      appName: packageInfo.appName,
      packageName: packageInfo.packageName,
      version: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
    );
  }
}
