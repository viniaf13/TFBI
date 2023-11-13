import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/widgets/focus_aware_widget.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_field_semantics_wrapper.dart';

class RegisterPasswordFormField extends StatefulWidget {
  const RegisterPasswordFormField({
    required this.registerPasswordController,
    required this.labelText,
    required this.onChanged,
    this.validator,
    super.key,
  });

  final TextEditingController registerPasswordController;
  final String labelText;
  final String? Function(String?)? validator;
  final void Function(String) onChanged;

  @override
  State<RegisterPasswordFormField> createState() =>
      _RegisterPasswordFormFieldState();
}

class _RegisterPasswordFormFieldState
    extends FocusAwareWidgetState<RegisterPasswordFormField> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldSemanticsWrapper(
      label: widget.labelText,
      child: TextFormField(
        key: formFieldKey,
        focusNode: focusNode,
        style: context.tfbText.bodyLightLarge.copyWith(
          color: TfbBrandColors.blueHighest,
        ),
        obscureText: obscurePassword,
        decoration: InputDecoration(
          labelText: widget.labelText,
          errorMaxLines: 2,
          suffixIcon: IconButton(
            onPressed: () => setState(() {
              obscurePassword = !obscurePassword;
            }),
            icon: Text(
              obscurePassword
                  ? context.getLocalizationOf.showPassword
                  : context.getLocalizationOf.hidePassword,
              style: context.tfbText.bodyMediumLarge
                  .copyWith(color: TfbBrandColors.grayHigh),
            ),
          ),
        ),
        controller: widget.registerPasswordController,
        validator: widget.validator,
        onChanged: widget.onChanged,
      ),
    );
  }
}
