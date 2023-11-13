import 'package:flutter/material.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

class TfbLocationValidator extends DataValidator<String> {
  TfbLocationValidator({required this.errorMessage});

  factory TfbLocationValidator.localized(
    BuildContext context,
  ) =>
      TfbLocationValidator(
        errorMessage:
            context.getLocalizationOf.minMaxLengthValidationMessage(40, 3),
      );

  final String errorMessage;

  @override
  String? validate(input) {
    if (input.isNullOrEmpty || input!.length < 3 || input.length > 40) {
      return errorMessage;
    }

    return null;
  }
}
