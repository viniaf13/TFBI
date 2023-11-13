import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';
import 'package:txfb_insurance_flutter/shared/widgets/focus_aware_widget.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_field_semantics_wrapper.dart';

class ConfirmPasswordFormField extends StatefulWidget {
  const ConfirmPasswordFormField({
    required this.confirmPasswordController,
    super.key,
  });

  final TextEditingController confirmPasswordController;

  @override
  State<ConfirmPasswordFormField> createState() =>
      _ConfirmPasswordFormFieldState();
}

class _ConfirmPasswordFormFieldState
    extends FocusAwareWidgetState<ConfirmPasswordFormField> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldSemanticsWrapper(
      label: context.getLocalizationOf.confirmPasswordLabel,
      child: TextFormField(
        key: formFieldKey,
        focusNode: focusNode,
        obscureText: obscurePassword,
        decoration: InputDecoration(
          labelText: context.getLocalizationOf.confirmPasswordLabel,
          suffixIcon: IconButton(
            onPressed: () => setState(() {
              obscurePassword = !obscurePassword;
            }),
            icon: Icon(
              obscurePassword
                  ? Icons.remove_red_eye
                  : Icons.remove_red_eye_outlined,
            ),
          ),
        ),
        controller: widget.confirmPasswordController,
      ),
    );
  }
}
