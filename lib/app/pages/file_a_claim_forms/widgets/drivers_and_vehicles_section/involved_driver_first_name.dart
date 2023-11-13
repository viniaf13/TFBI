import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/enum/form_validation_type.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';
import 'package:txfb_insurance_flutter/shared/widgets/validating_form_field.dart';

class TfbInvolvedDriverFirstName extends StatelessWidget {
  const TfbInvolvedDriverFirstName({
    required this.controller,
    required this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return ValidatingFormField(
      labelText: context.getLocalizationOf.insuredDriverFirstNameFieldLabel,
      type: ValidationType.involvedDriverFirstName,
      isRequired: true,
      controller: controller,
      onChanged: onChanged,
    );
  }
}
