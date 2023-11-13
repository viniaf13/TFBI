import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/bottom_sheet_type_of_loss.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/city_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/county_of_loss_bottom_sheet.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/loss_and_damage_header.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/police_case_number_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/police_department_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/state_bottom_sheet.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/time_of_loss_form_field.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_additional_description_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_city_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_location_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_police_case_number_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_police_department_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_required_field_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_state_field_validator.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_loss_info.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/enum/submit_claim_us_states.dart';
import 'package:txfb_insurance_flutter/shared/constants/spacing.dart';
import 'package:txfb_insurance_flutter/shared/enum/form_validation_type.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/widgets/validating_form_field.dart';

class LossAndDamageSection extends StatefulWidget {
  const LossAndDamageSection({
    required this.isFormValid,
    required this.dateOfLoss,
    required this.lossInfoNotifier,
    super.key,
  });

  final ValueNotifier<bool> isFormValid;
  final ValueNotifier<LossInformation> lossInfoNotifier;
  final String dateOfLoss;

  static String texasState = SubmitClaimUsStates.TX.value;
  static Duration animationDuration = const Duration(milliseconds: 250);

  @override
  State<LossAndDamageSection> createState() => _LossAndDamageSectionState();
}

class _LossAndDamageSectionState extends State<LossAndDamageSection> {
  late TextEditingController cityFieldController;

  late TextEditingController additionalDescriptionController;

  late TextEditingController locationFieldController;

  late TextEditingController typeOfLossController;

  late TextEditingController policeDepartmentFieldController;

  late TextEditingController policeCaseNumberFieldController;

  late TextEditingController countyOfLossFieldController;

  late TextEditingController stateFieldController;

  late TextEditingController timeOfLossFieldController;

  final isStateOfTexasSelected = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    cityFieldController = TextEditingController(
      text: widget.lossInfoNotifier.value.city,
    );
    additionalDescriptionController = TextEditingController(
      text: widget.lossInfoNotifier.value.lossDescription,
    );
    locationFieldController = TextEditingController(
      text: widget.lossInfoNotifier.value.location,
    );
    typeOfLossController = TextEditingController(
      text: widget.lossInfoNotifier.value.typeOfLoss,
    );
    policeDepartmentFieldController = TextEditingController(
      text: widget.lossInfoNotifier.value.policeDepartment,
    );
    policeCaseNumberFieldController = TextEditingController(
      text: widget.lossInfoNotifier.value.policeCaseNumber,
    );
    countyOfLossFieldController = TextEditingController(
      text: widget.lossInfoNotifier.value.county,
    );
    stateFieldController = TextEditingController(
      text: SubmitClaimUsStates.getValueFromAbbreviation(
            widget.lossInfoNotifier.value.state,
          ) ??
          SubmitClaimUsStates.TX.value,
    );
    timeOfLossFieldController = TextEditingController(
      text: widget.lossInfoNotifier.value.timeOfLoss,
    );

    widget.lossInfoNotifier.value = widget.lossInfoNotifier.value.copyWith(
      state: SubmitClaimUsStates.TX.abbreviation,
    );

    final stateFormFieldValidator = TfbStateFieldValidator.localized(
      context,
      context.getLocalizationOf.stateFieldName,
    );
    final cityFormFieldValidator = TfbCityValidator.localized(context);
    final policeDepartmentFormFieldValidator =
        TfbPoliceDepartmentValidator.localized(context);
    final policeCaseNumberFormFieldValidator =
        TfbPoliceCaseNumberValidator.localized(context);

    final timeOfLossFormFieldValidator = TfbRequiredFieldValidator.localized(
      context,
      context.getLocalizationOf.timeOfLossTypeFieldName,
      TfbFieldType.selectable,
    );
    final locationFormFieldValidator = TfbLocationValidator.localized(context);
    final additionalDescriptionFormFieldValidator =
        TfbAdditionalDescriptionValidator.localized(context);
    final typeOfLossFieldValidator = TfbRequiredFieldValidator.localized(
      context,
      context.getLocalizationOf.typeOfLossLabel,
      TfbFieldType.selectable,
    );

    void validateForm() {
      final isStateFormFieldValid =
          stateFormFieldValidator.validate(stateFieldController.text) == null;
      final isTimeOfLossFormFieldValid = timeOfLossFormFieldValidator
              .validate(timeOfLossFieldController.text) ==
          null;
      final isLocationFormFieldValid =
          locationFormFieldValidator.validate(locationFieldController.text) ==
              null;
      final isAdditionalDescriptionFieldValid =
          additionalDescriptionFormFieldValidator
                  .validate(additionalDescriptionController.text) ==
              null;
      final isCityFormFieldValid =
          cityFormFieldValidator.validate(cityFieldController.text) == null;
      final isTypeOfLossValid =
          typeOfLossFieldValidator.validate(typeOfLossController.text) == null;

      final isPoliceDepartmentFormFieldValid =
          policeDepartmentFormFieldValidator
                  .validate(policeDepartmentFieldController.text) ==
              null;
      final isPoliceCaseNumberFormFieldValid =
          policeCaseNumberFormFieldValidator
                  .validate(policeCaseNumberFieldController.text) ==
              null;

      widget.isFormValid.value = isTimeOfLossFormFieldValid &&
          isAdditionalDescriptionFieldValid &&
          isLocationFormFieldValid &&
          isStateFormFieldValid &&
          isCityFormFieldValid &&
          isTypeOfLossValid &&
          isPoliceDepartmentFormFieldValid &&
          isPoliceCaseNumberFormFieldValid;

      isStateOfTexasSelected.value =
          stateFieldController.text == LossAndDamageSection.texasState;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LossAndDamageHeader(
          dateOfLoss: widget.dateOfLoss,
        ),
        const SizedBox(
          height: kSpacingMedium,
        ),
        TimeOfLossFormField(
          controller: timeOfLossFieldController,
          onChanged: (value) {
            widget.lossInfoNotifier.value =
                widget.lossInfoNotifier.value.copyWith(
              timeOfLoss: value,
            );
            validateForm();
          },
          validator: timeOfLossFormFieldValidator.validate,
          dateOfLoss: widget.dateOfLoss,
        ),
        const SizedBox(
          height: kSpacingSmall,
        ),
        TypeOfLossBottomSheet(
          onChanged: (value) {
            widget.lossInfoNotifier.value =
                widget.lossInfoNotifier.value.copyWith(
              typeOfLoss: value as String,
            );
            validateForm();
          },
          selectedValueController: typeOfLossController,
          validator: typeOfLossFieldValidator.validate,
        ),
        const SizedBox(
          height: kSpacingSmall,
        ),
        ValidatingFormField(
          labelText: context.getLocalizationOf.additionalDescLossLabel,
          controller: additionalDescriptionController,
          showCharacterCount: true,
          type: ValidationType.description,
          isRequired: true,
          onChanged: (value) {
            widget.lossInfoNotifier.value =
                widget.lossInfoNotifier.value.copyWith(
              lossDescription: value,
            );
            validateForm();
          },
        ),
        const SizedBox(
          height: kSpacingSmall,
        ),
        ValidatingFormField(
          labelText: context.getLocalizationOf.locationTextFormField,
          controller: locationFieldController,
          showCharacterCount: true,
          type: ValidationType.location,
          isRequired: true,
          onChanged: (value) {
            widget.lossInfoNotifier.value =
                widget.lossInfoNotifier.value.copyWith(
              location: value,
            );
            validateForm();
          },
        ),
        const SizedBox(
          height: kSpacingSmall,
        ),
        StateBottomSheet(
          onChanged: (value) {
            widget.lossInfoNotifier.value =
                widget.lossInfoNotifier.value.copyWith(
              state: value as String,
            );
            validateForm();
          },
          selectedValueController: stateFieldController,
          validator: stateFormFieldValidator.validate,
        ),
        const SizedBox(
          height: kSpacingSmall,
        ),
        CityFormField(
          controller: cityFieldController,
          onChanged: (value) {
            widget.lossInfoNotifier.value =
                widget.lossInfoNotifier.value.copyWith(
              city: value,
            );
            validateForm();
          },
        ),
        const SizedBox(
          height: kSpacingSmall,
        ),
        ListenableBuilder(
          listenable: isStateOfTexasSelected,
          builder: (context, _) {
            return AnimatedSize(
              duration: LossAndDamageSection.animationDuration,
              reverseDuration: LossAndDamageSection.animationDuration,
              curve: Curves.easeInOut,
              child: isStateOfTexasSelected.value
                  ? Column(
                      children: [
                        CountyOfLossBottomSheet(
                          onChanged: (value) {
                            widget.lossInfoNotifier.value =
                                widget.lossInfoNotifier.value.copyWith(
                              county: value as String,
                            );
                            validateForm();
                          },
                          selectedValueController: countyOfLossFieldController,
                        ),
                        const SizedBox(
                          height: kSpacingSmall,
                        ),
                      ],
                    )
                  : const SizedBox(
                      height: 0,
                      width: double.infinity,
                    ),
            );
          },
        ),
        PoliceDepartmentFormField(
          controller: policeDepartmentFieldController,
          onChanged: (value) {
            widget.lossInfoNotifier.value =
                widget.lossInfoNotifier.value.copyWith(
              policeDepartment: value,
            );
            validateForm();
          },
        ),
        const SizedBox(
          height: kSpacingSmall,
        ),
        PoliceCaseNumberFormField(
          controller: policeCaseNumberFieldController,
          onChanged: (value) {
            widget.lossInfoNotifier.value =
                widget.lossInfoNotifier.value.copyWith(
              policeCaseNumber: value,
            );
            validateForm();
          },
        ),
      ],
    );
  }
}
