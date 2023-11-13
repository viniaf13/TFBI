import 'package:flutter/material.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

class TfbAdditionalDescriptionValidator extends DataValidator<String> {
  TfbAdditionalDescriptionValidator({required this.errorMessage});

  factory TfbAdditionalDescriptionValidator.localized(
    BuildContext context,
  ) =>
      TfbAdditionalDescriptionValidator(
        errorMessage:
            context.getLocalizationOf.minMaxLengthValidationMessage(1000, 2),
      );

  final String errorMessage;

  @override
  String? validate(input) {
    if (input.isNullOrEmpty || input!.length < 2 || input.length > 1000) {
      return errorMessage;
    }

    return null;
  }
}
