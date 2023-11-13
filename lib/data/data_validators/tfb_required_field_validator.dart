import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';

enum TfbFieldType { selectable, typeable }

class TfbRequiredFieldValidator extends DataValidator<String> {
  TfbRequiredFieldValidator({required this.errorMessage});

  factory TfbRequiredFieldValidator.localized(
    BuildContext context,
    String fieldName,
    TfbFieldType fieldType,
  ) =>
      TfbRequiredFieldValidator(
        errorMessage: fieldType == TfbFieldType.selectable
            ? context.getLocalizationOf.selectedFieldValidation(fieldName)
            : context.getLocalizationOf.validFieldValidation(fieldName),
      );

  final String errorMessage;

  @override
  String? validate(input) {
    if (input == null || input.trim().isEmpty) {
      return errorMessage;
    }

    return null;
  }
}
