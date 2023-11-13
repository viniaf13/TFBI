import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

enum TfbPolicyNumberValidatorErrorValidatorKey {
  isEmpty,
  minimumCharactersNotMet,
  maximumCharactersExceeded,
  notNumeric,
}

class TfbPolicyNumberValidator extends DataValidator<String> {
  TfbPolicyNumberValidator({
    required this.errorMessageMap,
  });

  factory TfbPolicyNumberValidator.localized(BuildContext context) =>
      TfbPolicyNumberValidator(
        errorMessageMap: {
          TfbPolicyNumberValidatorErrorValidatorKey.isEmpty:
              context.getLocalizationOf.policyNumberValidationLabel,
          TfbPolicyNumberValidatorErrorValidatorKey.maximumCharactersExceeded:
              context.getLocalizationOf.policyNumberValidationLabel,
          TfbPolicyNumberValidatorErrorValidatorKey.minimumCharactersNotMet:
              context.getLocalizationOf.policyNumberValidationLabel,
          TfbPolicyNumberValidatorErrorValidatorKey.notNumeric:
              context.getLocalizationOf.policyNumberValidationLabel,
        },
      );

  Map<TfbPolicyNumberValidatorErrorValidatorKey, String> errorMessageMap;

  @override
  String? validate(String? input) {
    if (input == null || input.isEmpty) {
      return errorMessageMap[TfbPolicyNumberValidatorErrorValidatorKey.isEmpty];
    }

    const minimumCharacters = 6;
    if (input.length < minimumCharacters) {
      return errorMessageMap[
          TfbPolicyNumberValidatorErrorValidatorKey.minimumCharactersNotMet];
    }

    const maximumCharacters = 10;
    if (input.length > maximumCharacters) {
      return errorMessageMap[
          TfbPolicyNumberValidatorErrorValidatorKey.maximumCharactersExceeded];
    }

    if (!input.isNumeric()) {
      return errorMessageMap[
          TfbPolicyNumberValidatorErrorValidatorKey.notNumeric];
    }

    return null;
  }
}
