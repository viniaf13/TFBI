import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/bottom_sheet_selector.dart';

class BottomSheetReporterType extends StatelessWidget {
  const BottomSheetReporterType({
    required this.onChanged,
    required this.selectedValueController,
    super.key,
    this.validator,
  });

  final void Function(dynamic) onChanged;
  final String? Function(String? value)? validator;
  final TextEditingController selectedValueController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubmitClaimBloc, SubmitClaimState>(
      builder: (context, state) {
        final List<BottomSheetSelectorOption> data = [];
        if (state is SubmitClaimFormInitSuccess) {
          for (final element in state.claimFormData.reporterType) {
            if (element != null) {
              data.add(
                BottomSheetSelectorOption(
                  label: element.value.toString(),
                  value: element.value.toString(),
                ),
              );
            }
          }
        }

        return Semantics(
          label: context.getLocalizationOf.selectionField(
            context.getLocalizationOf.reporterTypeTextFormField,
          ),
          child: BottomSheetSelector(
            title: context.getLocalizationOf.reporterTypeTextFormField,
            options: data,
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
