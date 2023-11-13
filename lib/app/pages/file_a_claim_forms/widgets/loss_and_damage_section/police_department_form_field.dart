import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/shared/enum/form_validation_type.dart';

import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/widgets/validating_form_field.dart';

class PoliceDepartmentFormField extends StatelessWidget {
  const PoliceDepartmentFormField({
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
    return ValidatingFormField(
      controller: controller,
      onChanged: onChanged,
      labelText: context.getLocalizationOf.policeDepartmentFormField,
      type: ValidationType.policeDepartment,
    );
  }
}
