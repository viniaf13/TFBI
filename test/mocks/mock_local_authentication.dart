import 'package:local_auth/local_auth.dart';
import 'package:local_auth_platform_interface/types/auth_messages.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/device/biometrics/tfb_biometrics.dart';

class MockLocalAuthenticationFalse extends Mock implements TfbBiometrics {
  @override
  Future<bool> isDeviceSupported() async => Future.value(false);

  @override
  Future<bool> get canCheckBiometrics => Future.value(false);

  @override
  Future<bool> authenticate({
    required String localizedReason,
    Iterable<AuthMessages> authMessages = const <AuthMessages>[],
    AuthenticationOptions options = const AuthenticationOptions(),
  }) =>
      Future.value(false);

  @override
  Future<bool> isAuthenticated() {
    return Future.value(false);
  }

  @override
  Future<bool> isBiometricsEnabled() async =>
      await isDeviceSupported() && await canCheckBiometrics;
}

class MockLocalAuthenticationTrue extends Mock implements TfbBiometrics {
  @override
  Future<bool> isDeviceSupported() async => Future.value(true);

  @override
  Future<bool> get canCheckBiometrics => Future.value(true);

  @override
  Future<bool> authenticate({
    required String localizedReason,
    Iterable<AuthMessages> authMessages = const <AuthMessages>[],
    AuthenticationOptions options = const AuthenticationOptions(),
  }) =>
      Future.value(true);

  @override
  Future<bool> isAuthenticated() {
    return Future.value(true);
  }

  @override
  Future<bool> isBiometricsEnabled() async =>
      await isDeviceSupported() && await canCheckBiometrics;
}
