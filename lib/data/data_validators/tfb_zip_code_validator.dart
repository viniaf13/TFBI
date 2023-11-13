import 'package:flutter/material.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

const minLength = 5;
const maxLength = 5;

class TfbZipCodeValidator extends DataValidator<String> {
  TfbZipCodeValidator({required this.errorMessage});

  factory TfbZipCodeValidator.localized(
    BuildContext context,
  ) =>
      TfbZipCodeValidator(
        errorMessage: context.getLocalizationOf
            .minMaxLengthValidationMessage(maxLength, minLength),
      );

  final String errorMessage;

  @override
  String? validate(input) {
    if (input.isNullOrEmpty) {
      return null;
    }
    if (input!.length < minLength || input.length > maxLength) {
      return errorMessage;
    }

    return null;
  }
}
