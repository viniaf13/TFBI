import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';
import 'package:txfb_insurance_flutter/shared/widgets/focus_aware_widget.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_field_semantics_wrapper.dart';

class ConfirmEmailFormField extends StatefulWidget {
  const ConfirmEmailFormField({
    required this.confirmEmailController,
    super.key,
  });

  final TextEditingController confirmEmailController;

  @override
  State<ConfirmEmailFormField> createState() => _ConfirmEmailFormFieldState();
}

class _ConfirmEmailFormFieldState
    extends FocusAwareWidgetState<ConfirmEmailFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFieldSemanticsWrapper(
      label: context.getLocalizationOf.inputField(
        context.getLocalizationOf.confirmEmailLabel,
      ),
      child: TextFormField(
        controller: widget.confirmEmailController,
        key: formFieldKey,
        focusNode: focusNode,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: context.getLocalizationOf.confirmEmailLabel,
        ),
      ),
    );
  }
}
