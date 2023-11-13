import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/shared/enum/form_validation_type.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:txfb_insurance_flutter/shared/widgets/validating_form_field.dart';

class ContactPhoneNumberFormField extends StatelessWidget {
  ContactPhoneNumberFormField({
    required this.label,
    required this.controller,
    required this.onChanged,
    this.isRequired = true,
    super.key,
  });

  final String label;
  final TextEditingController controller;
  final void Function(String value)? onChanged;
  final bool isRequired;

  final maskFormatter = MaskTextInputFormatter(
    mask: '###.###.####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  @override
  Widget build(
    BuildContext context,
  ) {
    return Semantics(
      label: context.getLocalizationOf.inputField(
        context.getLocalizationOf.preferredContactPhoneTextFormField,
      ),
      child: ValidatingFormField(
        isRequired: isRequired,
        autoFillHints: const [AutofillHints.telephoneNumber],
        controller: controller,
        onChanged: onChanged,
        labelText: label,
        inputFormatters: [maskFormatter],
        type: ValidationType.phone,
      ),
    );
  }
}
