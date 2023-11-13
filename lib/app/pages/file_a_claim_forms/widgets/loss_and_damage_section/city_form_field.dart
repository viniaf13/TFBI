import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/shared/enum/form_validation_type.dart';

import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/widgets/validating_form_field.dart';

class CityFormField extends StatelessWidget {
  const CityFormField({
    required this.controller,
    required this.onChanged,
    this.isRequired = true,
    super.key,
  });

  final TextEditingController controller;
  final void Function(String value)? onChanged;
  final bool isRequired;

  @override
  Widget build(
    BuildContext context,
  ) {
    return ValidatingFormField(
      isRequired: isRequired,
      autoFillHints: const [AutofillHints.addressCity],
      controller: controller,
      onChanged: onChanged,
      labelText: context.getLocalizationOf.cityFormField,
      type: ValidationType.city,
    );
  }
}
