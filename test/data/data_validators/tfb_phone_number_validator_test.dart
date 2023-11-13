import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_phone_number_validator.dart';

void main() {
  const emptyError = 'EMPTY';
  const lengthError = 'LENGTH';
  const notNumericError = 'NOT_NUMERIC';

  final TfbPhoneNumberValidator validator = TfbPhoneNumberValidator(
    errorMessageMap: {
      TfbPhoneNumberValidatorErrorValidatorKey.isEmpty: emptyError,
      TfbPhoneNumberValidatorErrorValidatorKey.invalidLength: lengthError,
      TfbPhoneNumberValidatorErrorValidatorKey.notNumeric: notNumericError,
    },
  );

  test('An empty string is caught and returns the empty error message',
      () async {
    expect(validator.validate(''), emptyError);
    expect(validator.validate(null), emptyError);
  });

  test('A string of invalid length is caught and returns the length error',
      () async {
    expect(validator.validate('123'), lengthError);
    expect(validator.validate('12345678910'), lengthError);
    expect(validator.validate('123.456.78'), lengthError);
  });

  test('A non-numeric string is caught and returns the not numeric error',
      () async {
    expect(validator.validate('ABCDEFHIJK'), notNumericError);
  });

  test('A valid phone number returns null', () async {
    expect(validator.validate('123.456.7890'), null);
    expect(validator.validate('1234567890'), null);
  });
}
