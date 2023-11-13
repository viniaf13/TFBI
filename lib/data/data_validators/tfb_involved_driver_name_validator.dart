import 'package:flutter/material.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

const minLength = 3;
const maxLength = 50;

class TfbInvolvedDriverNameValidator extends DataValidator<String> {
  TfbInvolvedDriverNameValidator({required this.errorMessage});

  factory TfbInvolvedDriverNameValidator.localized(
    BuildContext context,
  ) =>
      TfbInvolvedDriverNameValidator(
        errorMessage: context.getLocalizationOf
            .minMaxLengthValidationMessage(maxLength, minLength),
      );

  final String errorMessage;

  @override
  String? validate(input) {
    if (input.isNullOrEmpty ||
        input!.length < minLength ||
        input.length > maxLength) {
      return errorMessage;
    }

    return null;
  }
}
