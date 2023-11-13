import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/shared/enum/form_validation_type.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/yesno_button.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/yesno_card_header.dart';
import 'package:txfb_insurance_flutter/shared/widgets/validating_form_field.dart';

/// The IsVehicleDrivable widget presents onscreen as a pair of 'checkboxes'
/// for yes/no selection. The user _must positively_ select an answer, there
/// is no default value on purpose.

class IsVehicleDrivable extends StatefulWidget {
  const IsVehicleDrivable({
    required this.textEditingController,
    required this.yesNoValueNotifier,
    required this.onChange,
    super.key,
  });

  // Text input controller
  final TextEditingController textEditingController;
  final ValueNotifier<YesNoButtonKind?> yesNoValueNotifier;
  final void Function(String?) onChange;

  @override
  State<IsVehicleDrivable> createState() => _IsVehicleDrivableState();
}

class _IsVehicleDrivableState extends State<IsVehicleDrivable> {
  YesNoButtonKind? _value;
  bool hasBeenValidated = false;

  @override
  void initState() {
    super.initState();
    _value = widget.yesNoValueNotifier.value;
  }

  // method for yesno to twiddle the value, set state
  void _setYesNo(YesNoButtonKind newValue) {
    setState(() {
      _value = newValue;
    });
    widget.yesNoValueNotifier.value = newValue;
    widget.onChange(null);
  }

  // method to get yesno value
  YesNoButtonKind? _getYesNo() {
    return _value;
  }

  // method to validate that yesno has a value and that (if appropriate)
  // the text input has a value. This method might need to be moved up
  // a level in the widget tree.
  String? validate() {
    hasBeenValidated = true;
    if (_value == null) {
      return 'Please select an option';
    }
    return null; // this might be moved up a level...
  }

  @override
  Widget build(BuildContext context) {
    return YesNoCardHeader(
      title: 'Is the vehicle drivable?',
      onSelect: _setYesNo,
      selectionValue: _getYesNo,
      validationMessage: null,
      displayChildrenWhenSelected: YesNoButtonKind.no,
      child: ValidatingFormField(
        labelText: 'Current location of vehicle',
        showCharacterCount: true,
        type: ValidationType.location,
        controller: widget.textEditingController,
        isRequired: true,
        onChanged: (value) => widget.onChange(value),
      ),
    );
  }
}
