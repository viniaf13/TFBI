import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';

enum TfbDriverNameValidatorErrorValidatorKey {
  isEmpty,
  minMaxCharactersExceeded,
}

const minLength = 2;
const maxLength = 25;

class TfbDriverNameValidator extends DataValidator<String> {
  TfbDriverNameValidator({required this.errorMessageMap});

  factory TfbDriverNameValidator.localized(
    BuildContext context,
    String fieldName,
  ) =>
      TfbDriverNameValidator(
        errorMessageMap: {
          TfbDriverNameValidatorErrorValidatorKey.isEmpty:
              context.getLocalizationOf.validFieldValidation(fieldName),
          TfbDriverNameValidatorErrorValidatorKey.minMaxCharactersExceeded:
              context.getLocalizationOf
                  .minMaxLengthValidationMessage(maxLength, minLength),
        },
      );

  final Map<TfbDriverNameValidatorErrorValidatorKey, String> errorMessageMap;

  @override
  String? validate(input) {
    if (input == null || input.trim().isEmpty) {
      return errorMessageMap[TfbDriverNameValidatorErrorValidatorKey.isEmpty];
    }

    if (input.length < minLength || input.length > maxLength) {
      return errorMessageMap[
          TfbDriverNameValidatorErrorValidatorKey.minMaxCharactersExceeded];
    }

    return null;
  }
}
