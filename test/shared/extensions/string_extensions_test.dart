import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

void main() {
  test('toCapitalized returns capitalized string', () {
    const text = 'string';
    final capitalizedText = text.toCapitalized();
    expect(capitalizedText, 'String');
  });

  test('toCapitalized returns capitalized text', () {
    const text = 'string string';
    final capitalizedText = text.toTitleCase();
    expect(capitalizedText, 'String String');
  });

  test('PhoneNumberFormat returns formatted phone number', () {
    const number = '00000000000';
    final formattedPhoneNumber = number.formatPhoneNumber();
    expect(formattedPhoneNumber, '000.000.0000');
  });
}
