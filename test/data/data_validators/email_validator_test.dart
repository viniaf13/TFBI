import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_email_validator.dart';

void main() {
  test('Email validator returns the correct error string for an empty email',
      () {
    const notFoundString = 'NOT_FOUND';
    final validator = TfbEmailValidator(
      errorMessageMap: {
        EmailValidatorErrorMessageKeys.noEmailFound: notFoundString,
      },
    );

    final result = validator.validate('');

    expect(result, notFoundString);
  });

  test('Email validator returns the correct error string for an invalid email',
      () {
    const invalidString = 'INVALID_EMAIL';
    final validator = TfbEmailValidator(
      errorMessageMap: {
        EmailValidatorErrorMessageKeys.emailNotCorrectlyFormatted:
            invalidString,
      },
    );

    final result = validator.validate('NOT_VALID_EMAIL');

    expect(result, invalidString);
  });

  test('Email validator returns error string for all invalid emails.', () {
    const invalidString = 'INVALID_EMAIL';
    final validator = TfbEmailValidator(
      errorMessageMap: {
        EmailValidatorErrorMessageKeys.emailNotCorrectlyFormatted:
            invalidString,
      },
    );

    const allInvalidEmails = [
      'plainaddress',
      r'#@%^%#$@#$@#.com',
      '@example.com',
      'Joe Smith <email@example.com>',
      'email.example.com',
      'email@example@example.com',
      '.email@example.com',
      'email.@example.com',
      'email..email@example.com',
      'email@example.com (Joe Smith)',
      'email@example',
      'email@111.222.333.44444',
      'email@example..com',
      'Abc..123@example.com',
    ];

    for (final email in allInvalidEmails) {
      final result = validator.validate(email);
      expect(result, invalidString);
    }
  });

  test('Email validator returns null for valid emails', () {
    final validator = TfbEmailValidator(errorMessageMap: {});

    const allValidEmails = [
      'email@example.com',
      'firstname.lastname@example.com',
      'email@subdomain.example.com',
      'firstname+lastname@example.com',
      'email@123.123.123.123',
      'email@[123.123.123.123]',
      '"email"@example.com',
      '1234567890@example.com',
      'email@example-one.com',
      '_______@example.com',
      'email@example.name',
      'email@example.museum',
      'email@example.co.jp',
      'firstname-lastname@example.com',
    ];

    for (final email in allValidEmails) {
      final result = validator.validate(email);
      expect(result, null);
    }
  });
}
