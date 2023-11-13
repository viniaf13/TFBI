import 'package:flutter/material.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

const minLength = 2;
const maxLength = 250;

class TfbInvolvedDriverStreetValidator extends DataValidator<String> {
  TfbInvolvedDriverStreetValidator({required this.errorMessage});

  factory TfbInvolvedDriverStreetValidator.localized(
    BuildContext context,
  ) =>
      TfbInvolvedDriverStreetValidator(
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
