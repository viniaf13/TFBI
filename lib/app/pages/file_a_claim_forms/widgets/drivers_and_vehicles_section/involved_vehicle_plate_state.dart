import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';
import 'package:txfb_insurance_flutter/shared/widgets/bottom_sheet_selector.dart';

class TfbInvolvedVehiclePlateState extends StatelessWidget {
  const TfbInvolvedVehiclePlateState({
    required this.onChanged,
    required this.selectedValueController,
    super.key,
    this.validator,
  });

  final String? Function(String? value)? validator;
  final void Function(String) onChanged;
  final TextEditingController selectedValueController;

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
                  value: s.value,
                ),
              );
            }
          }
        }
        return Semantics(
          label: context.getLocalizationOf.selectionField(
            context.getLocalizationOf.driversLicensePlateStateLabel,
          ),
          child: BottomSheetSelector(
            title: context.getLocalizationOf.driversLicensePlateStateLabel,
            options: selectorItems.toList(),
            onChanged: (value) => onChanged(value as String),
            selectedValueController: selectedValueController,
            validator: validator,
          ),
        );
      },
    );
  }
}
