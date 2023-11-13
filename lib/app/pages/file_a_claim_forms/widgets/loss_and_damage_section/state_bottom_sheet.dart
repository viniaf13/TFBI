import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';
import 'package:txfb_insurance_flutter/shared/widgets/bottom_sheet_selector.dart';

class StateBottomSheet extends StatelessWidget {
  const StateBottomSheet({
    required this.onChanged,
    required this.selectedValueController,
    this.isRequired = true,
    super.key,
    this.validator,
  });
  final String? Function(String? value)? validator;
  final void Function(dynamic) onChanged;
  final TextEditingController selectedValueController;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubmitClaimBloc, SubmitClaimState>(
      builder: (context, state) {
        final List<BottomSheetSelectorOption> selectorItems = [];
        if (state is SubmitClaimFormInitSuccess) {
          for (final s in state.claimFormData.state) {
            if (s != null) {
              selectorItems.add(
                BottomSheetSelectorOption(
                  label: s.value,
                  value: s.abbreviation,
                ),
              );
            }
          }
        }
        return Semantics(
          label: context.getLocalizationOf
              .selectionField(context.getLocalizationOf.state),
          child: BottomSheetSelector(
            title: context.getLocalizationOf.state,
            options: selectorItems.toList(),
            onChanged: onChanged,
            requiredField: isRequired,
            selectedValueController: selectedValueController,
            validator: validator,
          ),
        );
      },
    );
  }
}
