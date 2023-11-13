import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_driver_name_validator.dart';

void main() {
  const emptyError = 'EMPTY';
  const minMaxError = 'MINMAXCHAREXCEEDED';

  final TfbDriverNameValidator validator = TfbDriverNameValidator(
    errorMessageMap: {
      TfbDriverNameValidatorErrorValidatorKey.isEmpty: emptyError,
      TfbDriverNameValidatorErrorValidatorKey.minMaxCharactersExceeded:
          minMaxError,
    },
  );

  test('An valid string is caught and returns null', () async {
    expect(validator.validate('validName'), null);
  });

  test('An empty string is caught and returns the empty error message',
      () async {
    expect(validator.validate(''), emptyError);
    expect(validator.validate(null), emptyError);
  });

  test(
      'Under the minimum character limit is caught and returns minimum error message',
      () {
    expect(validator.validate('a'), minMaxError);
  });

  test(
      'Over the maximum character limit is caught and returns maximum error message',
      () {
    expect(validator.validate('SUPERLONGSTRINGSUPERLONGSTRING'), minMaxError);
  });
}
