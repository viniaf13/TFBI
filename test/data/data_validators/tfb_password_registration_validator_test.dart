import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_password_registration_validator.dart';

void main() {
  final validator = TfbRegistrationPasswordValidator();

  void expectAllStringsToValidateWithError(
    List<String> strings,
    TfbRegistrationPasswordValidatorErrorMessageKeys errorKey,
  ) {
    strings
        .map(validator.validate)
        .map(containsExpectedErrorKey(errorKey))
        .expectAll(true);
  }

  test('Empty password returns empty password key', () async {
    expectAllStringsToValidateWithError(
      [''],
      TfbRegistrationPasswordValidatorErrorMessageKeys.passwordEmpty,
    );
  });

  test('Short password returns password below minimum length error', () async {
    expectAllStringsToValidateWithError(
      ['1234567890', '123456789012', 'hello', 'too_short'],
      TfbRegistrationPasswordValidatorErrorMessageKeys.minimumCharactersNotMet,
    );
  });

  test('Long password returns password above maximum length error', () {
    expectAllStringsToValidateWithError(
      [
        'this is a super long password that will not pass validation because it is longer than 99 characters!',
      ],
      TfbRegistrationPasswordValidatorErrorMessageKeys
          .overMaximumCharacterLimit,
    );
  });

  test(
      'Minimum letters requirement not met will return minimumLettersRequiredNotMet error',
      () {
    expectAllStringsToValidateWithError(
      ['1234567890', '123456789012', 'a123455678351241255'],
      TfbRegistrationPasswordValidatorErrorMessageKeys
          .minimumLettersRequiredNotMet,
    );
  });

  test(
      'Minimum numbers requirement not met will return minimumNumbersRequiredNotMet error',
      () {
    expectAllStringsToValidateWithError(
      [
        'abcabcabcabcabcabc',
        'this is a long string of text with no numbers',
        'hello world this is my test',
      ],
      TfbRegistrationPasswordValidatorErrorMessageKeys
          .minimumNumbersRequiredNotMet,
    );
  });

  test(
      'Minimum uppercase requirement not met will return minimumUppercaseLettersRequiredNotMet error',
      () {
    expectAllStringsToValidateWithError(
      ['this is an all lowercase string that should fail'],
      TfbRegistrationPasswordValidatorErrorMessageKeys
          .minimumUppercaseLettersRequiredNotMet,
    );
  });

  test(
      '3 or more concurrent characters will fail with moreThanTwoConcurrentCharacters error',
      () {
    expectAllStringsToValidateWithError(
      ['lll this has repeated characters', 'this one should not be alloweddd'],
      TfbRegistrationPasswordValidatorErrorMessageKeys
          .moreThanTwoConcurrentCharacters,
    );
  });

  test(
      'Using disallowed characters should return a usingDisallowedCharacters error',
      () {
    expectAllStringsToValidateWithError(
      ['niños', '池', '😊', 'password with : should not be allowed'],
      TfbRegistrationPasswordValidatorErrorMessageKeys
          .usingDisallowedCharacters,
    );
  });

  test('Valid passwords should not return any error messages', () {
    [
      'validPassword123',
      'MyVerySecurePassword2023',
      '98TexasFarmBureauPassword',
      r'specialCharactersTest100!@#$%^',
      '<><>123abcTXFB;)',
    ].map(validator.validate).map((e) => e.isEmpty).expectAll(true);
  });
}

bool Function(
  List<TfbRegistrationPasswordValidatorErrorMessageKeys> errorKeys,
) containsExpectedErrorKey(
  TfbRegistrationPasswordValidatorErrorMessageKeys key,
) =>
    (
      List<TfbRegistrationPasswordValidatorErrorMessageKeys> errorKeys,
    ) =>
        errorKeys.contains(
          key,
        );

extension ExpectIterableExtension on Iterable<dynamic> {
  void expectAll(
    dynamic value,
  ) {
    for (final item in this) {
      expect(item, value);
    }
  }
}
