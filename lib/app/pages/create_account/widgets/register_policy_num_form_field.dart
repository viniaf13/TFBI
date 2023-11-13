import 'package:txfb_insurance_flutter/data/data_validators/tfb_policy_number_validator.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_field_semantics_wrapper.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class PolicyNumberFormField extends StatefulWidget {
  const PolicyNumberFormField({
    required this.policyNumController,
    required this.policyNumberValidator,
    required this.onChanged,
    super.key,
  });

  final TextEditingController policyNumController;
  final TfbPolicyNumberValidator policyNumberValidator;
  final void Function(String) onChanged;

  @override
  State<PolicyNumberFormField> createState() => _PolicyNumberFormFieldState();
}

class _PolicyNumberFormFieldState
    extends FocusAwareWidgetState<PolicyNumberFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSpacingMedium),
      child: TextFieldSemanticsWrapper(
        label: context.getLocalizationOf.inputField(
          context.getLocalizationOf.policyNumLabel,
        ),
        child: TextFormField(
          key: formFieldKey,
          focusNode: focusNode,
          style: context.tfbText.bodyLightLarge.copyWith(
            color: TfbBrandColors.blueHighest,
          ),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            errorMaxLines: 2,
            labelText: context.getLocalizationOf.policyNumLabel,
          ),
          controller: widget.policyNumController,
          validator: widget.policyNumberValidator.validate,
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
