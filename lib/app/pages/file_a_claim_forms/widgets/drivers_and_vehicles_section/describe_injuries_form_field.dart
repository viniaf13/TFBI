import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/shared/enum/form_validation_type.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';
import 'package:txfb_insurance_flutter/shared/widgets/validating_form_field.dart';

class DescribeInjuriesFormField extends StatelessWidget {
  const DescribeInjuriesFormField({
    required this.controller,
    required this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final void Function(String value)? onChanged;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Semantics(
      label: context.getLocalizationOf.inputField(
        context.getLocalizationOf.describeInjuriesLabel,
      ),
      child: ValidatingFormField(
        isRequired: true,
        controller: controller,
        onChanged: onChanged,
        labelText: context.getLocalizationOf.describeInjuriesLabel,
        type: ValidationType.injuryDescription,
        showCharacterCount: true,
      ),
    );
  }
}
