import 'package:local_auth/local_auth.dart';
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/device/biometrics/local_auth_default_options.dart';

class TfbBiometrics extends LocalAuthentication {
  TfbBiometrics() {
    isBiometricsEnabled();
  }

  final options = LocalAuthDefaultOptions();

  /// Checks that the users device has biometrics enabled
  Future<bool> isBiometricsEnabled() async =>
      await isDeviceSupported() && await canCheckBiometrics;

  /// This is local authentication; Does the user pass biometrics check?
  Future<bool> isAuthenticated() => authenticate(
        localizedReason: options.reason,
        options: options.defaultOptions,
      );
}
