import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

enum TfbConfirmPasswordValidatorErrorKey {
  passwordsDontMatch,
  empty,
}

class TfbConfirmPasswordValidator extends DataValidator<String> {
  TfbConfirmPasswordValidator(
    this.registerPasswordController,
    this.registerConfirmPasswordController,
    this.errorMap,
  );

  factory TfbConfirmPasswordValidator.localized(
    TextEditingController registerPasswordController,
    TextEditingController confirmPasswordController,
    BuildContext context,
  ) =>
      TfbConfirmPasswordValidator(
        registerPasswordController,
        confirmPasswordController,
        {
          TfbConfirmPasswordValidatorErrorKey.passwordsDontMatch:
              context.getLocalizationOf.passwordDoNotMatchLabel,
          TfbConfirmPasswordValidatorErrorKey.empty:
              context.getLocalizationOf.emptyPasswordRegister,
        },
      );

  final TextEditingController registerPasswordController;
  final TextEditingController registerConfirmPasswordController;
  final Map<TfbConfirmPasswordValidatorErrorKey, String> errorMap;

  @override
  String? validate(String? input) {
    if (registerPasswordController.text !=
        registerConfirmPasswordController.text) {
      return errorMap[TfbConfirmPasswordValidatorErrorKey.passwordsDontMatch];
    } else if (registerConfirmPasswordController.text.isEmpty) {
      return errorMap[TfbConfirmPasswordValidatorErrorKey.empty];
    }
    return null;
  }
}
