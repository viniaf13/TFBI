import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

enum TfbInvolvedPhoneNumberValidatorErrorValidatorKey {
  invalidLength,
  notNumeric,
}

class TfbInvolvedPhoneNumberValidator extends DataValidator<String> {
  TfbInvolvedPhoneNumberValidator({
    required this.errorMessageMap,
  });

  factory TfbInvolvedPhoneNumberValidator.localized(BuildContext context) =>
      TfbInvolvedPhoneNumberValidator(
        errorMessageMap: {
          TfbInvolvedPhoneNumberValidatorErrorValidatorKey.invalidLength:
              context.getLocalizationOf.phoneNumberValidationLabel,
          TfbInvolvedPhoneNumberValidatorErrorValidatorKey.notNumeric:
              context.getLocalizationOf.phoneNumberValidationLabel,
        },
      );

  Map<TfbInvolvedPhoneNumberValidatorErrorValidatorKey, String> errorMessageMap;

  @override
  String? validate(String? input) {
    if (input == null || input.isEmpty) {
      return null;
    }

    final inputWithoutDots = input.replaceAll('.', '');

    const phoneNumberLength = 10;
    if (inputWithoutDots.length != phoneNumberLength) {
      return errorMessageMap[
          TfbInvolvedPhoneNumberValidatorErrorValidatorKey.invalidLength];
    }

    if (!inputWithoutDots.isNumeric()) {
      return errorMessageMap[
          TfbInvolvedPhoneNumberValidatorErrorValidatorKey.notNumeric];
    }

    return null;
  }
}
