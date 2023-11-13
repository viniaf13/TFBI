import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

enum TfbMemberNumberValidatorErrorValidatorKey {
  isEmpty,
  minimumCharactersNotMet,
  maximumCharactersExceeded,
  notAlphanumeric,
}

class TfbMemberNumberValidator extends DataValidator<String> {
  TfbMemberNumberValidator({
    required this.errorMessageMap,
  });

  factory TfbMemberNumberValidator.localized(BuildContext context) =>
      TfbMemberNumberValidator(
        errorMessageMap: {
          TfbMemberNumberValidatorErrorValidatorKey.isEmpty:
              context.getLocalizationOf.memberNumberValidationLabel,
          TfbMemberNumberValidatorErrorValidatorKey.maximumCharactersExceeded:
              context.getLocalizationOf.memberNumberValidationLabel,
          TfbMemberNumberValidatorErrorValidatorKey.minimumCharactersNotMet:
              context.getLocalizationOf.memberNumberValidationLabel,
          TfbMemberNumberValidatorErrorValidatorKey.notAlphanumeric:
              context.getLocalizationOf.memberNumberValidationLabel,
        },
      );

  Map<TfbMemberNumberValidatorErrorValidatorKey, String> errorMessageMap;

  @override
  String? validate(String? input) {
    if (input == null || input.isEmpty) {
      return errorMessageMap[TfbMemberNumberValidatorErrorValidatorKey.isEmpty];
    }

    const minimumCharacters = 4;
    if (input.length < minimumCharacters) {
      return errorMessageMap[
          TfbMemberNumberValidatorErrorValidatorKey.minimumCharactersNotMet];
    }

    const maximumCharacters = 6;
    if (input.length > maximumCharacters) {
      return errorMessageMap[
          TfbMemberNumberValidatorErrorValidatorKey.maximumCharactersExceeded];
    }

    if (!input.isAlphanumeric()) {
      return errorMessageMap[
          TfbMemberNumberValidatorErrorValidatorKey.notAlphanumeric];
    }

    return null;
  }
}
