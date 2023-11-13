import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';
import 'package:txfb_insurance_flutter/shared/widgets/bottom_sheet_selector.dart';

class ContactTypeBottomSheet extends StatelessWidget {
  const ContactTypeBottomSheet({
    required this.onChanged,
    required this.selectedValueController,
    required this.title,
    super.key,
    this.validator,
  });

  final String title;
  final String? Function(String? value)? validator;
  final void Function(dynamic) onChanged;
  final TextEditingController selectedValueController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubmitClaimBloc, SubmitClaimState>(
      builder: (context, state) {
        final List<BottomSheetSelectorOption> data = [];

        if (state is SubmitClaimFormInitSuccess) {
          for (final element in state.claimFormData.contactType) {
            if (element != null) {
              data.add(
                BottomSheetSelectorOption(
                  label: element.usageTypeName!.uiValue()!,
                  value: element.usageTypeCode!,
                ),
              );
            }
          }
        }

        return Semantics(
          label: context.getLocalizationOf.selectionField(title),
          child: BottomSheetSelector(
            title: title,
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
