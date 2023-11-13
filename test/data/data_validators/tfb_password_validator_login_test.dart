import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_password_login_validator.dart';

void main() {
  test(
      'TFB password validator returns correct error message for empty password',
      () {
    const noPasswordErrorString = 'EMPTY_PASSWORD';
    final validator = TfbLoginPasswordValidator(
      errorMessageMap: {
        TfbLoginPasswordValidationErrorMessageKeys.passwordEmpty:
            noPasswordErrorString,
      },
    );

    final result = validator.validate('');

    expect(result, noPasswordErrorString);
  });

  test(
      'TFB password validator returns null if anything is provided for the password',
      () {
    final validator = TfbLoginPasswordValidator(
      errorMessageMap: {},
    );

    final result = validator.validate('ANY_VALUE');

    expect(result, null);
  });
}
