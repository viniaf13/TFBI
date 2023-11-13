import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/describe_injuries_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/yesno_button.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/yesno_card_header.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

/// The WasAnyoneInjured widget presents onscreen as a pair of 'checkboxes'
/// for yes/no selection. The user _must positively_ select an answer, there
/// is no default value on purpose.

class WasAnyoneInjured extends StatefulWidget {
  const WasAnyoneInjured({
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
  State<WasAnyoneInjured> createState() => _WasAnyoneInjuredState();
}

class _WasAnyoneInjuredState extends State<WasAnyoneInjured> {
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

  @override
  Widget build(BuildContext context) {
    return YesNoCardHeader(
      title: context.getLocalizationOf.wasAnyoneInThisVehicleInjured,
      onSelect: _setYesNo,
      selectionValue: _getYesNo,
      validationMessage: null,
      displayChildrenWhenSelected: YesNoButtonKind.yes,
      child: DescribeInjuriesFormField(
        controller: widget.textEditingController,
        onChanged: (value) => widget.onChange(value),
      ),
    );
  }
}
