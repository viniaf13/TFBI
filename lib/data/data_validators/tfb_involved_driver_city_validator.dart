import 'package:flutter/material.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

const minLength = 3;
const maxLength = 25;

class TfbInvolvedDriverCityValidator extends DataValidator<String> {
  TfbInvolvedDriverCityValidator({required this.errorMessage});

  factory TfbInvolvedDriverCityValidator.localized(
    BuildContext context,
  ) =>
      TfbInvolvedDriverCityValidator(
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
