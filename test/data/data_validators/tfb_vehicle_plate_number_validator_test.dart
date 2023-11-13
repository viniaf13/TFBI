import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_vehicle_plate_number_validator.dart';

void main() {
  const minMaxError = 'MINMAXCHAREXCEEDED';

  final TfbVehicleLicensePlateNumberValidator validator =
      TfbVehicleLicensePlateNumberValidator(
    errorMessage: minMaxError,
  );

  test('An empty string is caught and returns null', () async {
    expect(validator.validate(''), null);
    expect(validator.validate(null), null);
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
    expect(validator.validate('SUPERLONGSTRINGSUPERLONGSTRING'), minMaxError);
  });
}
