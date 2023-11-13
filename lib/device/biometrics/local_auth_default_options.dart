// coverage:ignore-file

import 'package:local_auth/local_auth.dart';
import 'package:txfb_insurance_flutter/shared/constants/strings.dart';

class LocalAuthDefaultOptions implements AuthenticationOptions {
  /// Message on biometrics dialog while prompting them for authentication
  String get reason => kBiometricsReason;

  @override

  /// Set to true will prevent authentication using pin, passcode, or pattern.
  bool get biometricOnly => false;

  @override

  /// Setting to true enables platform specific precautions (Might be too much).
  bool get sensitiveTransaction => false;

  @override

  /// True will allow OS to resume auth when lifecycle is resumed, else cancel
  bool get stickyAuth => true;

  @override

  /// True allows OS to use dialogs in attempt to fix auth problems
  bool get useErrorDialogs => true;

  AuthenticationOptions get defaultOptions => AuthenticationOptions(
        useErrorDialogs: useErrorDialogs,
        stickyAuth: stickyAuth,
        sensitiveTransaction: sensitiveTransaction,
        biometricOnly: biometricOnly,
      );
}
