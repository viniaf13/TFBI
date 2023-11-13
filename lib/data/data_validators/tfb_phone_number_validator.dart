import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

enum TfbPhoneNumberValidatorErrorValidatorKey {
  isEmpty,
  invalidLength,
  notNumeric,
}

class TfbPhoneNumberValidator extends DataValidator<String> {
  TfbPhoneNumberValidator({
    required this.errorMessageMap,
  });

  factory TfbPhoneNumberValidator.localized(BuildContext context) =>
      TfbPhoneNumberValidator(
        errorMessageMap: {
          TfbPhoneNumberValidatorErrorValidatorKey.isEmpty:
              context.getLocalizationOf.phoneNumberValidationLabel,
          TfbPhoneNumberValidatorErrorValidatorKey.invalidLength:
              context.getLocalizationOf.phoneNumberValidationLabel,
          TfbPhoneNumberValidatorErrorValidatorKey.notNumeric:
              context.getLocalizationOf.phoneNumberValidationLabel,
        },
      );

  Map<TfbPhoneNumberValidatorErrorValidatorKey, String> errorMessageMap;

  @override
  String? validate(String? input) {
    if (input == null || input.isEmpty) {
      return errorMessageMap[TfbPhoneNumberValidatorErrorValidatorKey.isEmpty];
    }

    final inputWithoutDots = input.replaceAll('.', '');

    const phoneNumberLength = 10;
    if (inputWithoutDots.length != phoneNumberLength) {
      return errorMessageMap[
          TfbPhoneNumberValidatorErrorValidatorKey.invalidLength];
    }

    if (!inputWithoutDots.isNumeric()) {
      return errorMessageMap[
          TfbPhoneNumberValidatorErrorValidatorKey.notNumeric];
    }

    return null;
  }
}
