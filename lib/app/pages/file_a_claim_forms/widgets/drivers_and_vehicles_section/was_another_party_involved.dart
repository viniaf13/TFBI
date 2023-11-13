import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/yesno_button.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/yesno_card_header.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

/// The WasAnotherPartyInvolved widget presents onscreen as a pair of 'checkboxes'
/// for yes/no selection. The user _must positively_ select an answer, there
/// is no default value on purpose.

class WasAnotherPartyInvolved extends StatefulWidget {
  const WasAnotherPartyInvolved({
    required this.yesNoValueNotifier,
    required this.onChange,
    required this.child,
    super.key,
  });

  final Widget child;
  final ValueNotifier<YesNoButtonKind?> yesNoValueNotifier;
  final void Function(YesNoButtonKind) onChange;

  @override
  State<WasAnotherPartyInvolved> createState() =>
      _WasAnotherPartyInvolvedState();
}

class _WasAnotherPartyInvolvedState extends State<WasAnotherPartyInvolved> {
  YesNoButtonKind? _value;

  // method for yesno to twiddle the value, set state
  void _setYesNo(YesNoButtonKind newValue) {
    setState(() {
      _value = newValue;
    });
    widget.yesNoValueNotifier.value = newValue;
    widget.onChange(newValue);
  }

  // method to get yesno value
  YesNoButtonKind? _getYesNo() {
    return _value;
  }

  @override
  Widget build(BuildContext context) {
    return YesNoCardHeader(
      title: context.getLocalizationOf.wasAnotherPartyInvolvedLabel,
      onSelect: _setYesNo,
      selectionValue: _getYesNo,
      validationMessage: null,
      displayChildrenWhenSelected: YesNoButtonKind.yes,
      child: widget.child,
    );
  }
}
