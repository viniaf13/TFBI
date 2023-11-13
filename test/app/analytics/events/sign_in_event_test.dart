import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/sign_in_events.dart';

void main() {
  group('SignInEvent', () {
    test(
        'Constructor should create an instance with the correct properties for biometrics',
        () {
      final signInEvent =
          SignInEvent(usedBiometrics: true, memberNumber: '123456');

      expect(signInEvent.name, 'sign_in');
      expect(signInEvent.properties['authentication_method'], 'Biometrics');
      expect(signInEvent.properties['member_number'], '123456');
      expect(signInEvent.properties['cta'], 'Sign in');
    });

    test(
        'Constructor should create an instance with the correct properties for password',
        () {
      final signInEvent =
          SignInEvent(usedBiometrics: false, memberNumber: '789012');

      expect(signInEvent.name, 'sign_in');
      expect(signInEvent.properties['authentication_method'], 'Password');
      expect(signInEvent.properties['member_number'], '789012');
      expect(signInEvent.properties['cta'], 'Sign in');
    });
  });
}
