import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

enum TfbInitialsValidatorKey {
  isNotAlpha,
  isNotNull,
  isNotTooShort,
}

class TfbInitialsValidator extends DataValidator<String> {
  TfbInitialsValidator({
    required this.errorMessageMap,
  });

  factory TfbInitialsValidator.localized(BuildContext context) =>
      TfbInitialsValidator(
        errorMessageMap: {
          TfbInitialsValidatorKey.isNotAlpha:
              context.getLocalizationOf.initialsMustBeAlpha,
          TfbInitialsValidatorKey.isNotNull:
              context.getLocalizationOf.enterTwoCharacterInitials,
          TfbInitialsValidatorKey.isNotTooShort:
              context.getLocalizationOf.enterTwoCharacterInitials,
        },
      );

  Map<TfbInitialsValidatorKey, String> errorMessageMap;

  @override
  String? validate(input) {
    if (input == null) {
      return errorMessageMap[TfbInitialsValidatorKey.isNotNull];
    }

    if (input.length < 2) {
      return errorMessageMap[TfbInitialsValidatorKey.isNotTooShort];
    }

    if (!input.isAlpha()) {
      return errorMessageMap[TfbInitialsValidatorKey.isNotAlpha];
    }

    return null;
  }
}
