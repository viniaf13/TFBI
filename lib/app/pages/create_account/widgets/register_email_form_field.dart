import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/widgets/focus_aware_widget.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_field_semantics_wrapper.dart';

class RegisterEmailFormField extends StatefulWidget {
  const RegisterEmailFormField({
    required this.registerEmailController,
    required this.labelText,
    required this.onChange,
    required this.validator,
    super.key,
  });

  final DataValidator<String> validator;
  final String labelText;
  final TextEditingController registerEmailController;
  final void Function(String) onChange;

  @override
  State<RegisterEmailFormField> createState() => _RegisterEmailFormFieldState();
}

class _RegisterEmailFormFieldState
    extends FocusAwareWidgetState<RegisterEmailFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFieldSemanticsWrapper(
      label: context.getLocalizationOf.inputField(widget.labelText),
      child: TextFormField(
        controller: widget.registerEmailController,
        key: formFieldKey,
        focusNode: focusNode,
        style: context.tfbText.bodyLightLarge.copyWith(
          color: TfbBrandColors.blueHighest,
        ),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          errorMaxLines: 2,
          labelText: widget.labelText,
        ),
        validator: widget.validator.validate,
        onChanged: widget.onChange,
      ),
    );
  }
}
