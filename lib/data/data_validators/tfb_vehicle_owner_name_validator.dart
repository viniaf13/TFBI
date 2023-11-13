import 'package:flutter/material.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';

const minLength = 2;
const maxLength = 25;

class TfbVehicleOwnerNameValidator extends DataValidator<String> {
  TfbVehicleOwnerNameValidator({required this.errorMessage});

  factory TfbVehicleOwnerNameValidator.localized(
    BuildContext context,
  ) =>
      TfbVehicleOwnerNameValidator(
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
