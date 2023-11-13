import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';

const minLength = 4;
const maxLength = 13;

class TfbDriverLicenseNumberValidator extends DataValidator<String> {
  TfbDriverLicenseNumberValidator({required this.errorMessage});

  factory TfbDriverLicenseNumberValidator.localized(
    BuildContext context,
  ) =>
      TfbDriverLicenseNumberValidator(
        errorMessage: context.getLocalizationOf
            .minMaxLengthValidationMessage(maxLength, minLength),
      );

  final String errorMessage;

  @override
  String? validate(input) {
    if (input == null || input.trim().isEmpty) {
      return null;
    }

    if (input.length < minLength || input.length > maxLength) {
      return errorMessage;
    }

    return null;
  }
}
