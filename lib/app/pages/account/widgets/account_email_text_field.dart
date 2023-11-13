import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_field_semantics_wrapper.dart';

class AccountEmailTextField extends StatefulWidget {
  const AccountEmailTextField({
    required this.controller,
    required this.onChanged,
    required this.validator,
    super.key,
  });

  final TextEditingController controller;
  final void Function(String value)? onChanged;
  final DataValidator<String> validator;

  @override
  State<AccountEmailTextField> createState() => _AccountEmailTextFieldState();
}

class _AccountEmailTextFieldState
    extends FocusAwareWidgetState<AccountEmailTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFieldSemanticsWrapper(
      label: context.getLocalizationOf.updateEmailTextFormLabel,
      child: TextFormField(
        key: formFieldKey,
        focusNode: focusNode,
        scrollPadding: const EdgeInsets.only(bottom: 124),
        controller: widget.controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: context.getLocalizationOf.updateEmailTextFormLabel,
        ),
        autofocus: true,
        validator: widget.validator.validate,
        onChanged: (value) {
          if (widget.validator.validate(value) == null) {
            validateOnNextFrame();
          }
          widget.onChanged?.call(value);
        },
      ),
    );
  }
}
