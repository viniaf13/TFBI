import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/contact_type_bottom_sheet.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/contact_phone_number_form_field.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_phone_number_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_required_field_validator.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/enum/phone_types_enum.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class PreferredSection extends StatefulWidget {
  const PreferredSection({
    required this.isFormValid,
    required this.preferredContactPhoneFieldController,
    required this.preferredContactType,
    super.key,
  });

  final ValueNotifier<bool> isFormValid;
  final TextEditingController preferredContactPhoneFieldController;
  final ValueNotifier<String?> preferredContactType;

  @override
  State<PreferredSection> createState() => _PreferredSectionState();
}

class _PreferredSectionState extends State<PreferredSection> {
  late TextEditingController preferredContactTypeFieldController;

  @override
  Widget build(BuildContext context) {
    final phoneNumberFormFieldValidator =
        TfbPhoneNumberValidator.localized(context);
    preferredContactTypeFieldController = TextEditingController(
      text: PhoneTypesEnum.getUiValueFromValue(
        widget.preferredContactType.value,
      ),
    );
    final preferredContactTypeFormFieldValidator =
        TfbRequiredFieldValidator.localized(
      context,
      context.getLocalizationOf.preferredContactTypeFieldName,
      TfbFieldType.selectable,
    );

    void validateForm() {
      final isPhoneNumberFormFieldValid = phoneNumberFormFieldValidator
              .validate(widget.preferredContactPhoneFieldController.text) ==
          null;
      final isPreferredContactTypeFormFieldValid =
          preferredContactTypeFormFieldValidator
                  .validate(preferredContactTypeFieldController.text) ==
              null;

      widget.isFormValid.value =
          isPhoneNumberFormFieldValid && isPreferredContactTypeFormFieldValid;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContactPhoneNumberFormField(
          label: context.getLocalizationOf.preferredContactPhoneTextFormField,
          controller: widget.preferredContactPhoneFieldController,
          onChanged: (_) => validateForm(),
        ),
        const SizedBox(
          height: kSpacingSmall,
        ),
        ContactTypeBottomSheet(
          title: context.getLocalizationOf.preferredContactType,
          onChanged: (value) {
            widget.preferredContactType.value = value as String;
            validateForm();
          },
          selectedValueController: preferredContactTypeFieldController,
          validator: preferredContactTypeFormFieldValidator.validate,
        ),
      ],
    );
  }
}
