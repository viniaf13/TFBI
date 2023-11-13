import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

enum TfbConfirmEmailValidatorErrorKey {
  emailsDontMatch,
  empty,
}

class TfbConfirmEmailValidator extends DataValidator<String> {
  TfbConfirmEmailValidator(
    this.registerEmailController,
    this.registerConfirmEmailController,
    this.errorMap,
  );

  factory TfbConfirmEmailValidator.localized(
    TextEditingController registerEmailController,
    TextEditingController confirmEmailController,
    BuildContext context,
  ) {
    return TfbConfirmEmailValidator(
      registerEmailController,
      confirmEmailController,
      {
        TfbConfirmEmailValidatorErrorKey.emailsDontMatch:
            context.getLocalizationOf.emailsDoNotMatch,
        TfbConfirmEmailValidatorErrorKey.empty:
            context.getLocalizationOf.emailEmptyRegister,
      },
    );
  }

  final TextEditingController registerEmailController;
  final TextEditingController registerConfirmEmailController;
  final Map<TfbConfirmEmailValidatorErrorKey, String> errorMap;

  @override
  String? validate(String? input) {
    if (registerEmailController.text != registerConfirmEmailController.text) {
      return errorMap[TfbConfirmEmailValidatorErrorKey.emailsDontMatch];
    } else if (registerConfirmEmailController.text.isEmpty) {
      return errorMap[TfbConfirmEmailValidatorErrorKey.empty];
    }
    return null;
  }
}
