import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_password_login_validator.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_field_semantics_wrapper.dart';

class LoginPasswordFormField extends StatefulWidget {
  const LoginPasswordFormField({
    required this.passwordController,
    this.onChange,
    super.key,
  });

  final TextEditingController passwordController;
  final void Function(String)? onChange;

  @override
  State<LoginPasswordFormField> createState() => _LoginPasswordFormFieldState();
}

class _LoginPasswordFormFieldState
    extends FocusAwareWidgetState<LoginPasswordFormField> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final passwordValidator = createPasswordValidator(context);

    return Padding(
      padding: const EdgeInsets.only(top: kSpacingSmall),
      child: TextFieldSemanticsWrapper(
        label: context.getLocalizationOf.inputField(
          context.getLocalizationOf.loginPasswordLabel,
        ),
        child: TextFormField(
          key: formFieldKey,
          focusNode: focusNode,
          obscureText: obscurePassword,
          obscuringCharacter: '*',
          decoration: InputDecoration(
            labelText: context.getLocalizationOf.loginPasswordLabel,
            suffixIcon: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => setState(() {
                obscurePassword = !obscurePassword;
              }),
              icon: Text(
                obscurePassword ? 'show' : 'hide',
                style: context.tfbText.bodyMediumLarge.copyWith(
                  color: TfbBrandColors.grayHigh,
                ),
              ),
            ),
          ),
          validator: passwordValidator.validate,
          autofillHints: const [AutofillHints.password],
          controller: widget.passwordController,
          style: context.tfbText.bodyLightLarge.copyWith(
            color: TfbBrandColors.blueHighest,
          ),
          onChanged: widget.onChange,
        ),
      ),
    );
  }
}

TfbLoginPasswordValidator createPasswordValidator(BuildContext context) {
  final passwordValidator = TfbLoginPasswordValidator(
    errorMessageMap: {
      TfbLoginPasswordValidationErrorMessageKeys.passwordEmpty:
          context.getLocalizationOf.loginPasswordEmpty,
    },
  );
  return passwordValidator;
}
