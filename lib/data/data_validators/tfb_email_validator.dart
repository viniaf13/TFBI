import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

enum EmailValidatorErrorMessageKeys { noEmailFound, emailNotCorrectlyFormatted }

class TfbEmailValidator extends DataValidator<String> {
  TfbEmailValidator({
    required this.errorMessageMap,
  });

  factory TfbEmailValidator.localizedFileAClaimForm(BuildContext context) =>
      TfbEmailValidator(
        errorMessageMap: {
          EmailValidatorErrorMessageKeys.emailNotCorrectlyFormatted:
              context.getLocalizationOf.emailErrorRegister,
        },
      );

  factory TfbEmailValidator.localizedRegistration(BuildContext context) =>
      TfbEmailValidator(
        errorMessageMap: {
          EmailValidatorErrorMessageKeys.noEmailFound:
              context.getLocalizationOf.emailEmptyRegister,
          EmailValidatorErrorMessageKeys.emailNotCorrectlyFormatted:
              context.getLocalizationOf.emailErrorRegister,
        },
      );

  factory TfbEmailValidator.localizedLogin(BuildContext context) =>
      TfbEmailValidator(
        errorMessageMap: {
          EmailValidatorErrorMessageKeys.noEmailFound:
              context.getLocalizationOf.emailEmpty,
          EmailValidatorErrorMessageKeys.emailNotCorrectlyFormatted:
              context.getLocalizationOf.emailNotValid,
        },
      );

  factory TfbEmailValidator.localizedForgotPassword(BuildContext context) =>
      TfbEmailValidator(
        errorMessageMap: {
          EmailValidatorErrorMessageKeys.noEmailFound:
              context.getLocalizationOf.emailEmptyForgotPassword,
          EmailValidatorErrorMessageKeys.emailNotCorrectlyFormatted:
              context.getLocalizationOf.emailInvalidForgotPassword,
        },
      );

  Map<EmailValidatorErrorMessageKeys, String> errorMessageMap;

  @override
  String? validate(String? input) {
    if (input == null || input.isEmpty) {
      return errorMessageMap[EmailValidatorErrorMessageKeys.noEmailFound];
    }

    // If you use this Regex, make sure to pass an uppercase version of the string
    final RegExp matcher = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );

    if (!matcher.hasMatch(input.toUpperCase())) {
      return errorMessageMap[
          EmailValidatorErrorMessageKeys.emailNotCorrectlyFormatted];
    }

    return null;
  }
}
