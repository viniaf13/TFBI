import 'package:flutter/material.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

class TfbCityValidator extends DataValidator<String> {
  TfbCityValidator({required this.errorMessage});

  factory TfbCityValidator.localized(
    BuildContext context,
  ) =>
      TfbCityValidator(
        errorMessage:
            context.getLocalizationOf.minMaxLengthValidationMessage(25, 3),
      );

  final String errorMessage;

  @override
  String? validate(input) {
    if (input.isNullOrEmpty || input!.length < 3 || input.length > 25) {
      return errorMessage;
    }

    return null;
  }
}
