import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';
import 'package:plugin_haven/plugin_haven.dart';

class TfbInsuredVehicleFieldValidator extends DataValidator<String> {
  TfbInsuredVehicleFieldValidator({required this.errorMessage});

  factory TfbInsuredVehicleFieldValidator.localized(
    BuildContext context,
    String fieldName,
  ) =>
      TfbInsuredVehicleFieldValidator(
        errorMessage:
            context.getLocalizationOf.insuredVehicleFieldValidation(fieldName),
      );

  final String errorMessage;

  @override
  String? validate(input) {
    if (input.isNullOrEmpty) {
      return errorMessage;
    }

    return null;
  }
}
