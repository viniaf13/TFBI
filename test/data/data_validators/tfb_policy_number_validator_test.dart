import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_policy_number_validator.dart';

void main() {
  const emptyError = 'EMPTY';
  const minimumError = 'MINIMUM';
  const maximumError = 'MAXIMUM';
  const notNumberic = 'NOT_NUMERIC';

  final TfbPolicyNumberValidator validator = TfbPolicyNumberValidator(
    errorMessageMap: {
      TfbPolicyNumberValidatorErrorValidatorKey.isEmpty: emptyError,
      TfbPolicyNumberValidatorErrorValidatorKey.minimumCharactersNotMet:
          minimumError,
      TfbPolicyNumberValidatorErrorValidatorKey.maximumCharactersExceeded:
          maximumError,
      TfbPolicyNumberValidatorErrorValidatorKey.notNumeric: notNumberic,
    },
  );

  test('An empty string is caught and returns the empty error message',
      () async {
    expect(validator.validate(''), emptyError);
    expect(validator.validate(null), emptyError);
  });

  test(
      'Under the minimum character limit is caught and returns minimum error message',
      () {
    expect(validator.validate('a'), minimumError);
    expect(validator.validate('abcvv'), minimumError);
  });

  test(
      'Over the maximum character limit is caught and returns maximum error message',
      () {
    expect(validator.validate('AAAAAAAAAAA'), maximumError);
    expect(validator.validate('SUPERLONGSTRINGSUPERLONGSTRING'), maximumError);
  });

  test(
      'Not alphanumber characters will be caught and return the numeric error message',
      () {
    expect(validator.validate('%!@AVVss'), notNumberic);
    expect(validator.validate('ñiñosss'), notNumberic);
  });

  test('Valid policy numbers return null and nothing is caught.', () {
    const validPolicyNumbers = [
      '123123',
      '1234567',
      '12345678',
      '987654321',
      '1234567890',
    ];

    for (final validNumber in validPolicyNumbers) {
      expect(validator.validate(validNumber), null);
    }
  });
}
