import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/blocs/biometrics/biometrics_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/biometrics_icon.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_email_validator.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_field_semantics_wrapper.dart';

class LoginEmailFormField extends StatefulWidget {
  const LoginEmailFormField({
    required this.emailController,
    required this.validator,
    required this.showBiometricIcon,
    this.onChange,
    this.disabled = false,
    super.key,
  });

  final TextEditingController emailController;
  final TfbEmailValidator validator;
  final bool disabled;
  final bool showBiometricIcon;
  final void Function(String value)? onChange;

  @override
  State<LoginEmailFormField> createState() => _LoginEmailFormFieldState();
}

class _LoginEmailFormFieldState
    extends FocusAwareWidgetState<LoginEmailFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFieldSemanticsWrapper(
      label: context.getLocalizationOf.inputField(
        context.getLocalizationOf.emailLabel,
      ),
      child: TextFormField(
        key: formFieldKey,
        readOnly: widget.disabled,
        focusNode: focusNode,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: context.getLocalizationOf.emailLabel,
          suffixIcon: GestureDetector(
            onTap: () => context
                .read<BiometricsBloc>()
                .add(const PromptBiometricsIfAvailable(fromTap: true)),
            child: widget.showBiometricIcon ? const BiometricsIcon() : null,
          ),
          suffixIconConstraints:
              const BoxConstraints(maxHeight: 24, maxWidth: 24),
        ),
        validator: (str) => widget.validator.validate(str?.trim()),
        autofillHints: const [AutofillHints.email],
        controller: widget.emailController,
        style: context.tfbText.bodyLightLarge.copyWith(
          color: TfbBrandColors.blueHighest,
        ),
        onChanged: widget.onChange,
      ),
    );
  }
}
