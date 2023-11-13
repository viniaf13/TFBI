import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

class TfbPoliceCaseNumberValidator extends DataValidator<String> {
  TfbPoliceCaseNumberValidator({required this.errorMessage});

  factory TfbPoliceCaseNumberValidator.localized(
    BuildContext context,
  ) =>
      TfbPoliceCaseNumberValidator(
        errorMessage:
            context.getLocalizationOf.minMaxLengthValidationMessage(25, 2),
      );

  final String errorMessage;

  @override
  String? validate(input) {
    if (input!.length == 1 || input.length > 25) {
      return errorMessage;
    }

    return null;
  }
}
