import 'package:flutter/material.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

class TfbInjuryDescriptionValidator extends DataValidator<String> {
  TfbInjuryDescriptionValidator({required this.errorMessage});

  factory TfbInjuryDescriptionValidator.localized(
    BuildContext context,
  ) =>
      TfbInjuryDescriptionValidator(
        errorMessage:
            context.getLocalizationOf.minMaxLengthValidationMessage(50, 3),
      );

  final String errorMessage;

  @override
  String? validate(input) {
    if (input.isNullOrEmpty || input!.length < 3 || input.length > 50) {
      return errorMessage;
    }

    return null;
  }
}
