import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';
import 'package:txfb_insurance_flutter/shared/widgets/bottom_sheet_selector.dart';

class InsuredVehicleBottomSheet extends StatelessWidget {
  const InsuredVehicleBottomSheet({
    required this.onChanged,
    required this.selectedValueController,
    super.key,
    this.validator,
  });

  final String? Function(String? value)? validator;
  final void Function(dynamic) onChanged;
  final TextEditingController selectedValueController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubmitClaimBloc, SubmitClaimState>(
      builder: (context, state) {
        final List<BottomSheetSelectorOption> selectorItems = [];
        if (state is SubmitClaimFormInitSuccess &&
            state.claimFormData.policyDetails?.vehicles != null) {
          for (final element in state.claimFormData.policyDetails!.vehicles!) {
            selectorItems.add(
              BottomSheetSelectorOption(
                label: element.yearMakeModel(),
                value: element,
              ),
            );
          }
        }
        return Semantics(
          label: context.getLocalizationOf.selectionField(
            context.getLocalizationOf.insuredVehicleFieldLabel,
          ),
          child: BottomSheetSelector(
            title: context.getLocalizationOf.insuredVehicleFieldLabel,
            options: selectorItems.toList(),
            onChanged: onChanged,
            requiredField: true,
            selectedValueController: selectedValueController,
            validator: validator,
          ),
        );
      },
    );
  }
}
