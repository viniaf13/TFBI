import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_member_number_validator.dart';

void main() {
  const emptyError = 'EMPTY';
  const minimumError = 'MINIMUM';
  const maximumError = 'MAXIMUM';
  const notAlphanumeric = 'NOT_ALPHANUM';

  final TfbMemberNumberValidator validator = TfbMemberNumberValidator(
    errorMessageMap: {
      TfbMemberNumberValidatorErrorValidatorKey.isEmpty: emptyError,
      TfbMemberNumberValidatorErrorValidatorKey.minimumCharactersNotMet:
          minimumError,
      TfbMemberNumberValidatorErrorValidatorKey.maximumCharactersExceeded:
          maximumError,
      TfbMemberNumberValidatorErrorValidatorKey.notAlphanumeric:
          notAlphanumeric,
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
    expect(validator.validate('abc'), minimumError);
  });

  test(
      'Over the maximum character limit is caught and returns maximum error message',
      () {
    expect(validator.validate('abc123a'), maximumError);
    expect(validator.validate('SUPERLONGSTRING'), maximumError);
  });

  test(
      'Not alphanumber characters will be caught and return the alphanumberic error message',
      () {
    expect(validator.validate('%!@AVV'), notAlphanumeric);
    expect(validator.validate('ñiños'), notAlphanumeric);
  });

  test('Valid member numbers return null and nothing is caught.', () {
    const validMemberNumbers = [
      '123abc',
      'AB12',
      '123FD',
      'SMILE',
      '51023',
    ];

    for (final validNumber in validMemberNumbers) {
      expect(validator.validate(validNumber), null);
    }
  });
}
