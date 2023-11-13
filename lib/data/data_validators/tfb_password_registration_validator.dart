import 'package:txfb_insurance_flutter/shared/extensions/string_validator_extension.dart';

enum TfbRegistrationPasswordValidatorErrorMessageKeys {
  passwordEmpty,
  minimumCharactersNotMet,
  overMaximumCharacterLimit,
  minimumLettersRequiredNotMet,
  minimumNumbersRequiredNotMet,
  minimumUppercaseLettersRequiredNotMet,
  moreThanTwoConcurrentCharacters,
  usingDisallowedCharacters,
}

/// A class to customize the rules for password validation, defaults to the
/// ones defined by TXFB.
class TfbRegistrationPasswordValidatorRules {
  TfbRegistrationPasswordValidatorRules({
    required this.minimumCharacters,
    required this.maximumCharacters,
    required this.lettersRequired,
    required this.numbersRequired,
    required this.uppercaseLettersRequired,
    required this.numberOfConcurrentCharactersAllowed,
  });

  const TfbRegistrationPasswordValidatorRules.defaultRules()
      : minimumCharacters = 16,
        maximumCharacters = 99,
        lettersRequired = 2,
        numbersRequired = 2,
        uppercaseLettersRequired = 1,
        numberOfConcurrentCharactersAllowed = 2;

  final int minimumCharacters;
  final int maximumCharacters;
  final int lettersRequired;
  final int numbersRequired;
  final int uppercaseLettersRequired;
  final int numberOfConcurrentCharactersAllowed;
}

/// Specifying Login password validator here, because the registration
/// validation will be different than the login ones.
class TfbRegistrationPasswordValidator {
  List<TfbRegistrationPasswordValidatorErrorMessageKeys> validate(
    String input, {
    TfbRegistrationPasswordValidatorRules rules =
        const TfbRegistrationPasswordValidatorRules.defaultRules(),
  }) {
    final List<TfbRegistrationPasswordValidatorErrorMessageKeys> errors = [];

    if (input.isEmpty) {
      errors
          .add(TfbRegistrationPasswordValidatorErrorMessageKeys.passwordEmpty);
    }

    if (input.length < rules.minimumCharacters) {
      errors.add(
        TfbRegistrationPasswordValidatorErrorMessageKeys
            .minimumCharactersNotMet,
      );
    }

    if (input.length > rules.maximumCharacters) {
      errors.add(
        TfbRegistrationPasswordValidatorErrorMessageKeys
            .overMaximumCharacterLimit,
      );
    }

    if (!input.hasNLetters(rules.lettersRequired)) {
      errors.add(
        TfbRegistrationPasswordValidatorErrorMessageKeys
            .minimumLettersRequiredNotMet,
      );
    }

    if (!input.hasNNumbers(rules.numbersRequired)) {
      errors.add(
        TfbRegistrationPasswordValidatorErrorMessageKeys
            .minimumNumbersRequiredNotMet,
      );
    }

    if (!input.hasNUppercaseLetters(rules.uppercaseLettersRequired)) {
      errors.add(
        TfbRegistrationPasswordValidatorErrorMessageKeys
            .minimumUppercaseLettersRequiredNotMet,
      );
    }

    if (input.hasMoreThanNConcurrentLetters(
      rules.numberOfConcurrentCharactersAllowed,
    )) {
      errors.add(
        TfbRegistrationPasswordValidatorErrorMessageKeys
            .moreThanTwoConcurrentCharacters,
      );
    }

    if (!input.usesOnlyAllowedCharacters()) {
      errors.add(
        TfbRegistrationPasswordValidatorErrorMessageKeys
            .usingDisallowedCharacters,
      );
    }

    return errors;
  }
}
