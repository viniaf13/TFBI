import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_required_field_validator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

void main() {
  final TfbRequiredFieldValidator fieldValidator = TfbRequiredFieldValidator(
    errorMessage: AppLocalizationsEn().selectedFieldValidation(''),
  );

  testWidgets('TFB Field Validator should return null if string is valid',
      (tester) async {
    expect(
      fieldValidator.validate('STRING'),
      null,
    );
  });

  testWidgets('TFB Field Validator should validate string empty',
      (tester) async {
    expect(
      fieldValidator.validate(''),
      AppLocalizationsEn().selectedFieldValidation(''),
    );
  });

  testWidgets('TFB Field Validator should validate string null',
      (tester) async {
    expect(
      fieldValidator.validate(null),
      AppLocalizationsEn().selectedFieldValidation(''),
    );
  });
}
