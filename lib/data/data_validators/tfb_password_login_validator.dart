import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';

enum TfbLoginPasswordValidationErrorMessageKeys { passwordEmpty }

/// Specifying Login password validator here, because the registration
/// validation will be different than the login ones.
class TfbLoginPasswordValidator extends DataValidator<String> {
  TfbLoginPasswordValidator({
    required this.errorMessageMap,
  });

  Map<TfbLoginPasswordValidationErrorMessageKeys, String> errorMessageMap;

  @override
  String? validate(String? input) {
    if (input == null || input.isEmpty) {
      return errorMessageMap[
          TfbLoginPasswordValidationErrorMessageKeys.passwordEmpty];
    }

    return null;
  }
}
