import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_involved_driver_name_validator.dart';

void main() {
  const minMaxError = 'MINMAXCHAREXCEEDED';

  final TfbInvolvedDriverNameValidator validator =
      TfbInvolvedDriverNameValidator(
    errorMessage: minMaxError,
  );

  test('An empty string is caught and returns null', () async {
    expect(validator.validate(''), minMaxError);
    expect(validator.validate(null), minMaxError);
  });

  test('An valid string is caught and returns null', () async {
    expect(validator.validate('testing'), null);
  });

  test(
      'Under the minimum character limit is caught and returns minimum error message',
      () {
    expect(validator.validate('a'), minMaxError);
  });

  test(
      'Over the maximum character limit is caught and returns maximum error message',
      () {
    expect(
      validator.validate(List.generate(51, (index) => 'a').join()),
      minMaxError,
    );
  });
}
