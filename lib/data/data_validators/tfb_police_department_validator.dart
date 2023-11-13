import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

class TfbPoliceDepartmentValidator extends DataValidator<String> {
  TfbPoliceDepartmentValidator({required this.errorMessage});

  factory TfbPoliceDepartmentValidator.localized(
    BuildContext context,
  ) =>
      TfbPoliceDepartmentValidator(
        errorMessage:
            context.getLocalizationOf.minMaxLengthValidationMessage(40, 2),
      );

  final String errorMessage;

  @override
  String? validate(input) {
    if (input!.length == 1 || input.length > 40) {
      return errorMessage;
    }

    return null;
  }
}
