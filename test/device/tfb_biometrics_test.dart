import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/device/biometrics/tfb_biometrics.dart';

import '../mocks/mock_local_authentication.dart';

void main() {
  group('Testing Biometrics', () {
    test(
      'Given a user with a device without biometrics support, when `isBiometricsEnabled` is called, then false should be returned',
      () async {
        final TfbBiometrics biometrics = MockLocalAuthenticationFalse();

        expect(await biometrics.isBiometricsEnabled(), isFalse);
      },
    );

    test(
      'Given a user with a device with biometrics support, when `isBiometricsEnabled` is called, then true should be returned',
      () async {
        final TfbBiometrics biometrics = MockLocalAuthenticationTrue();

        expect(await biometrics.isBiometricsEnabled(), isTrue);
      },
    );

    test(
      'Given a user with failing biometrics, when `isAuthenticated` is called, then false should be returned',
      () async {
        final TfbBiometrics biometrics = MockLocalAuthenticationFalse();

        final result = await biometrics.isAuthenticated();
        expect(result, false);
      },
    );

    test(
      'Given a user with passing biometrics, when `isAuthenticated` is called, then true should be returned',
      () async {
        final TfbBiometrics biometrics = MockLocalAuthenticationTrue();

        final result = await biometrics.isAuthenticated();
        expect(result, true);
      },
    );
  });
}
