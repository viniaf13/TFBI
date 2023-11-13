import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/bottom_sheet_insured_driver.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/bottom_sheet_license_state.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/bottom_sheet_vehicle_make.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/bottom_sheet_vehicle_model.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/bottom_sheet_vehicle_year.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/driver_first_name_field.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/driver_last_name_field.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/driver_license_number_field.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/drivers_and_vehicles_header.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/insured_vehicle_bottom_sheet.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/involved_driver_first_name.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/involved_driver_last_name.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/involved_vehicle_plate_number.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/involved_vehicle_plate_state.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/owner_first_name.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/owner_last_name.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/street_address_field.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/was_another_party_involved.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/zip_code_field.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/contact_phone_number_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/city_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/state_bottom_sheet.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_driver_license_number_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_driver_name_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_insured_vehicle_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_involved_driver_city_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_involved_driver_name_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_involved_driver_street_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_involved_phone_number_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_required_field_validator.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_auto_primary_insured.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_owner_information.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_make.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_model.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_vehicle_owner_name_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_vehicle_plate_number_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_zip_code_validator.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/policy_details/vehicles.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_address.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_name.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/auto_policy_detail.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/is_vehicle_drivable.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/was_anyone_injured.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/yesno_button.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_injury_description_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_vehicle_location_validator.dart';
import 'package:txfb_insurance_flutter/shared/constants/spacing.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

class DriversAndVehiclesSection extends StatefulWidget {
  const DriversAndVehiclesSection({
    required this.isFormValid,
    required this.isNewDriverNotifier,
    required this.hasFormBeenSubmitedNotifier,
    required this.insuredDriverInfoNotifier,
    required this.insuredVehicleInfoNotifier,
    required this.thirdPartyDriverInfoNotifier,
    required this.thirdPartyVehicleInfoNotifier,
    super.key,
  });

  final ValueNotifier<bool> isFormValid;
  final ValueNotifier<bool> isNewDriverNotifier;
  final ValueNotifier<bool> hasFormBeenSubmitedNotifier;
  final ValueNotifier<AutoPrimaryInsured> insuredDriverInfoNotifier;
  final ValueNotifier<SubmitClaimVehicle> insuredVehicleInfoNotifier;
  final ValueNotifier<AutoPrimaryInsured?> thirdPartyDriverInfoNotifier;
  final ValueNotifier<SubmitClaimVehicle?> thirdPartyVehicleInfoNotifier;

  @override
  State<DriversAndVehiclesSection> createState() =>
      _DriversAndVehiclesSectionState();
}

class _DriversAndVehiclesSectionState extends State<DriversAndVehiclesSection> {
  final animationDuration = const Duration(milliseconds: 250);

  late TextEditingController insuredDriverFieldController;
  late TextEditingController insuredDriverFirstName;
  late TextEditingController insuredDriverLastName;
  late TextEditingController insuredDriverLicenseNumber;
  late TextEditingController insuredDriverLicenseState;
  late TextEditingController insuredVehicleFieldController;
  late TextEditingController describeInjuriesFieldController;
  late ValueNotifier<YesNoButtonKind?> isVehicleDrivableValue;
  late ValueNotifier<YesNoButtonKind?> isAnyoneInjuredValue;
  late TextEditingController isVehicleDrivableLocationController;
  late ValueNotifier<YesNoButtonKind?> isAnotherPartyInvolvedValue;

  late TextEditingController involvedDriverFirstName;
  late TextEditingController involvedDriverLastName;
  late TextEditingController involvedDriverStreetAddress;
  late TextEditingController involvedDriverCity;
  late TextEditingController involvedDriverZipCode;
  late TextEditingController involvedDriverPhone;
  late TextEditingController involvedDriverLicenseNumber;
  late TextEditingController involvedVehicleLicensePlateNumber;
  late TextEditingController involvedVehicleOwnerFirstName;
  late TextEditingController involvedVehicleOwnerLastName;
  late ValueNotifier<YesNoButtonKind?> isInvolvedVehicleDrivableValue;
  late TextEditingController isInvolvedVehicleDrivableLocationController;
  late ValueNotifier<YesNoButtonKind?> isAnyoneInvolvedInjuredValue;
  late TextEditingController describeInvolvedInjuriesFieldController;
  late TextEditingController vehicleYearFieldController;
  late TextEditingController vehicleMakeFieldController;
  late TextEditingController vehicleModelFieldController;
  late TextEditingController involvedDriverState;
  late TextEditingController involvedDriverLicenseState;
  late TextEditingController involvedVehicleLicensePlateState;

  final enableMakeField = ValueNotifier(false);
  final enableModelField = ValueNotifier(false);

  YesNoButtonKind? getCheckboxValueFromNotifier(String? notifierValue) {
    if (notifierValue == 'Y') {
      return YesNoButtonKind.yes;
    }
    if (notifierValue == 'N') {
      return YesNoButtonKind.no;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    //Text fields
    final driver = widget.isNewDriverNotifier.value
        ? context.getLocalizationOf.reporterTypeOther
        : widget.insuredDriverInfoNotifier.value.name?.displayName;
    insuredDriverFieldController = TextEditingController(
      text: driver,
    );
    insuredDriverFirstName = TextEditingController(
      text: widget.insuredDriverInfoNotifier.value.name?.firstName,
    );
    insuredDriverLastName = TextEditingController(
      text: widget.insuredDriverInfoNotifier.value.name?.lastName,
    );
    insuredDriverLicenseNumber = TextEditingController(
      text: widget.insuredDriverInfoNotifier.value.licenseNumber,
    );
    insuredDriverLicenseState = TextEditingController(
      text: widget.insuredDriverInfoNotifier.value.licenseState,
    );
    final vehicle = widget.insuredVehicleInfoNotifier.value;
    insuredVehicleFieldController = TextEditingController(
      text: vehicle.id != null
          ? '${vehicle.year} ${vehicle.make} ${vehicle.model}'
          : null,
    );
    describeInjuriesFieldController = TextEditingController(
      text: widget.insuredDriverInfoNotifier.value.injuryDescription,
    );
    isVehicleDrivableValue = ValueNotifier<YesNoButtonKind?>(
      getCheckboxValueFromNotifier(
        widget.insuredVehicleInfoNotifier.value.isDriveable,
      ),
    );
    isAnyoneInjuredValue = ValueNotifier<YesNoButtonKind?>(
      getCheckboxValueFromNotifier(
        widget.insuredDriverInfoNotifier.value.injuryInd,
      ),
    );
    isVehicleDrivableLocationController = TextEditingController(
      text: widget.insuredVehicleInfoNotifier.value.currentLocation,
    );
    if (widget.hasFormBeenSubmitedNotifier.value) {
      isAnotherPartyInvolvedValue = ValueNotifier<YesNoButtonKind?>(
        widget.thirdPartyDriverInfoNotifier.value != null
            ? YesNoButtonKind.yes
            : YesNoButtonKind.no,
      );
    } else {
      isAnotherPartyInvolvedValue = ValueNotifier<YesNoButtonKind?>(null);
    }
    involvedDriverFirstName = TextEditingController(
      text: widget.thirdPartyDriverInfoNotifier.value?.name?.firstName,
    );
    involvedDriverLastName = TextEditingController(
      text: widget.thirdPartyDriverInfoNotifier.value?.name?.lastName,
    );
    involvedDriverStreetAddress = TextEditingController(
      text: widget.thirdPartyDriverInfoNotifier.value?.address?.addressLine1,
    );
    involvedDriverCity = TextEditingController(
      text: widget.thirdPartyDriverInfoNotifier.value?.address?.city,
    );
    involvedDriverZipCode = TextEditingController(
      text: widget.thirdPartyDriverInfoNotifier.value?.address?.zip,
    );
    involvedDriverPhone = TextEditingController(
      text: widget.thirdPartyDriverInfoNotifier.value?.phone,
    );
    involvedDriverLicenseNumber = TextEditingController(
      text: widget.thirdPartyDriverInfoNotifier.value?.licenseNumber,
    );
    involvedVehicleLicensePlateNumber = TextEditingController(
      text: widget.thirdPartyVehicleInfoNotifier.value?.licensePlate,
    );
    involvedVehicleOwnerFirstName = TextEditingController(
      text: widget
          .thirdPartyVehicleInfoNotifier.value?.ownerInformation?.firstName,
    );
    involvedVehicleOwnerLastName = TextEditingController(
      text: widget
          .thirdPartyVehicleInfoNotifier.value?.ownerInformation?.lastName,
    );
    isInvolvedVehicleDrivableValue = ValueNotifier<YesNoButtonKind?>(
      getCheckboxValueFromNotifier(
        widget.thirdPartyVehicleInfoNotifier.value?.isDriveable,
      ),
    );
    isInvolvedVehicleDrivableLocationController = TextEditingController(
      text: widget.thirdPartyVehicleInfoNotifier.value?.currentLocation,
    );
    isAnyoneInvolvedInjuredValue = ValueNotifier<YesNoButtonKind?>(
      getCheckboxValueFromNotifier(
        widget.thirdPartyDriverInfoNotifier.value?.injuryInd,
      ),
    );
    describeInvolvedInjuriesFieldController = TextEditingController(
      text: widget.thirdPartyDriverInfoNotifier.value?.injuryDescription,
    );
    vehicleYearFieldController = TextEditingController(
      text: widget.thirdPartyVehicleInfoNotifier.value?.year,
    );
    vehicleMakeFieldController = TextEditingController(
      text: widget.thirdPartyVehicleInfoNotifier.value?.make,
    );
    vehicleModelFieldController = TextEditingController(
      text: widget.thirdPartyVehicleInfoNotifier.value?.model,
    );
    involvedDriverState = TextEditingController(
      text: widget.thirdPartyDriverInfoNotifier.value?.address?.state,
    );
    involvedDriverLicenseState = TextEditingController(
      text: widget.thirdPartyDriverInfoNotifier.value?.licenseState,
    );
    involvedVehicleLicensePlateState = TextEditingController(
      text: widget.thirdPartyVehicleInfoNotifier.value?.licensePlateState,
    );

    //Validators
    final insuredDriverValidator = TfbRequiredFieldValidator.localized(
      context,
      context.getLocalizationOf.insuredDriverFieldLabel,
      TfbFieldType.selectable,
    );
    final insuredDriverFirstNameValidator = TfbDriverNameValidator.localized(
      context,
      context.getLocalizationOf.insuredDriverFirstNameFieldLabel,
    );
    final insuredDriverLastNameValidator = TfbDriverNameValidator.localized(
      context,
      context.getLocalizationOf.insuredDriverLastNameFieldLabel,
    );
    final insuredDriverLicenseNumberValidator =
        TfbDriverLicenseNumberValidator.localized(context);
    final insuredVehicleFormFieldValidator =
        TfbInsuredVehicleFieldValidator.localized(
      context,
      context.getLocalizationOf.stateFieldName,
    );
    final injuryDescriptionFormFieldValidator =
        TfbInjuryDescriptionValidator.localized(context);
    final vehicleLocationFormFieldValidator =
        TfbVehicleLocationValidator.localized(context);
    final involvedDriverFirstNameValidator =
        TfbInvolvedDriverNameValidator.localized(context);
    final involvedDriverLastNameValidator =
        TfbInvolvedDriverNameValidator.localized(context);
    final involvedDriverStreetValidator =
        TfbInvolvedDriverStreetValidator.localized(context);
    final involvedDriverCityValidator =
        TfbInvolvedDriverCityValidator.localized(context);
    final involvedDriverZipCodeValidator =
        TfbZipCodeValidator.localized(context);
    final involvedPhoneNumberValidator =
        TfbInvolvedPhoneNumberValidator.localized(context);
    final involvedLicenseNumberValidator =
        TfbDriverLicenseNumberValidator.localized(context);
    final involvedLicensePlateNumberValidator =
        TfbVehicleLicensePlateNumberValidator.localized(context);
    final involvedVehicleOwnerFirstNameValidator =
        TfbVehicleOwnerNameValidator.localized(context);
    final involvedVehicleOwnerLastNameValidator =
        TfbVehicleOwnerNameValidator.localized(context);
    final involvedVehicleLocationValidator =
        TfbVehicleLocationValidator.localized(context);
    final involvedVehicleInjuryDescriptionValidator =
        TfbInjuryDescriptionValidator.localized(context);
    final vehicleYearFieldValidator = TfbRequiredFieldValidator.localized(
      context,
      context.getLocalizationOf.vehicleYearLabel,
      TfbFieldType.selectable,
    );
    final vehicleMakeFieldValidator = TfbRequiredFieldValidator.localized(
      context,
      context.getLocalizationOf.vehicleMakeLabel,
      TfbFieldType.selectable,
    );

    void validateForm() {
      final isInsuredDriverFieldValid =
          insuredDriverValidator.validate(insuredDriverFieldController.text) ==
              null;
      final isDriverFirstNameFieldValid = insuredDriverFirstNameValidator
              .validate(insuredDriverFirstName.text) ==
          null;
      final isDriverLastNameFieldValid =
          insuredDriverLastNameValidator.validate(insuredDriverLastName.text) ==
              null;
      final isDriverLicenseNumberFieldValid =
          insuredDriverLicenseNumberValidator
                  .validate(insuredDriverLicenseNumber.text) ==
              null;
      final isInsuredVehicleFormFieldValid = insuredVehicleFormFieldValidator
              .validate(insuredVehicleFieldController.text) ==
          null;
      final isVehicleDrivableSelectionValid =
          isVehicleDrivableValue.value != null;
      final isLocationStringValid = vehicleLocationFormFieldValidator
                  .validate(isVehicleDrivableLocationController.text) ==
              null ||
          isVehicleDrivableValue.value == YesNoButtonKind.yes;
      final isAnyoneInjuredSelectionValid = isAnyoneInjuredValue.value != null;
      final isInjuryDescriptionValid =
          isAnyoneInjuredValue.value == YesNoButtonKind.no ||
              injuryDescriptionFormFieldValidator
                      .validate(describeInjuriesFieldController.text) ==
                  null;
      final isAnotherPartyInvolvedSelectionValid =
          isAnotherPartyInvolvedValue.value != null;
      final isInvolvedDriverFirstNameValid =
          isAnotherPartyInvolvedValue.value == YesNoButtonKind.no ||
              involvedDriverFirstNameValidator
                      .validate(involvedDriverFirstName.text) ==
                  null;
      final isInvolvedDriverLastNameValid =
          isAnotherPartyInvolvedValue.value == YesNoButtonKind.no ||
              involvedDriverLastNameValidator
                      .validate(involvedDriverLastName.text) ==
                  null;
      final isStreedAddressValid =
          isAnotherPartyInvolvedValue.value == YesNoButtonKind.no ||
              involvedDriverStreetValidator
                      .validate(involvedDriverStreetAddress.text) ==
                  null;
      final isInvolvedDriverCityValid = isAnotherPartyInvolvedValue.value ==
              YesNoButtonKind.no ||
          involvedDriverCityValidator.validate(involvedDriverCity.text) == null;
      final isZipCodeValid = isAnotherPartyInvolvedValue.value ==
              YesNoButtonKind.no ||
          involvedDriverZipCodeValidator.validate(involvedDriverZipCode.text) ==
              null;
      final isInvolvedDriverPhoneNumberValid =
          isAnotherPartyInvolvedValue.value == YesNoButtonKind.no ||
              involvedPhoneNumberValidator.validate(involvedDriverPhone.text) ==
                  null;
      final isInvolvedDriverLicenseNumberValid =
          isAnotherPartyInvolvedValue.value == YesNoButtonKind.no ||
              involvedLicenseNumberValidator
                      .validate(involvedDriverLicenseNumber.text) ==
                  null;
      final isInvolvedVehicleLicensePlateNumberValid =
          isAnotherPartyInvolvedValue.value == YesNoButtonKind.no ||
              involvedLicensePlateNumberValidator.validate(
                    involvedVehicleLicensePlateNumber.text,
                  ) ==
                  null;
      final isInvolvedVehicleOwnerFirstNameValid =
          isAnotherPartyInvolvedValue.value == YesNoButtonKind.no ||
              involvedVehicleOwnerFirstNameValidator
                      .validate(involvedVehicleOwnerFirstName.text) ==
                  null;
      final isInvolvedVehicleOwnerLastNameValid =
          isAnotherPartyInvolvedValue.value == YesNoButtonKind.no ||
              involvedVehicleOwnerLastNameValidator
                      .validate(involvedVehicleOwnerLastName.text) ==
                  null;
      final isInvolvedVehicleCurrentLocationValid =
          isAnotherPartyInvolvedValue.value == YesNoButtonKind.no ||
              isInvolvedVehicleDrivableValue.value == YesNoButtonKind.yes ||
              involvedVehicleLocationValidator.validate(
                    isInvolvedVehicleDrivableLocationController.text,
                  ) ==
                  null;
      final isInvolvedVehicleInjuryDescValid =
          isAnotherPartyInvolvedValue.value == YesNoButtonKind.no ||
              isAnyoneInvolvedInjuredValue.value == YesNoButtonKind.no ||
              involvedVehicleInjuryDescriptionValidator.validate(
                    describeInvolvedInjuriesFieldController.text,
                  ) ==
                  null;
      final isVehicleYearFieldValid = isAnotherPartyInvolvedValue.value ==
              YesNoButtonKind.no ||
          vehicleYearFieldValidator.validate(vehicleYearFieldController.text) ==
              null;
      final isVehicleMakeFieldValid = isAnotherPartyInvolvedValue.value ==
              YesNoButtonKind.no ||
          vehicleMakeFieldValidator.validate(vehicleMakeFieldController.text) ==
              null;
      final isVehicleModelFieldValid =
          isAnotherPartyInvolvedValue.value == YesNoButtonKind.no ||
              vehicleYearFieldValidator
                      .validate(vehicleModelFieldController.text) ==
                  null;

      /// Common validations for either choosing Other insured driver or not
      final commonValidations = isInsuredDriverFieldValid &&
          isInsuredVehicleFormFieldValid &&
          isVehicleDrivableSelectionValid &&
          isLocationStringValid &&
          isAnyoneInjuredSelectionValid &&
          isInjuryDescriptionValid &&
          isAnotherPartyInvolvedSelectionValid &&
          isInvolvedDriverFirstNameValid &&
          isInvolvedDriverLastNameValid &&
          isStreedAddressValid &&
          isInvolvedDriverCityValid &&
          isZipCodeValid &&
          isInvolvedDriverPhoneNumberValid &&
          isInvolvedDriverLicenseNumberValid &&
          isInvolvedVehicleLicensePlateNumberValid &&
          isInvolvedVehicleOwnerFirstNameValid &&
          isInvolvedVehicleOwnerLastNameValid &&
          isInvolvedVehicleCurrentLocationValid &&
          isInvolvedVehicleInjuryDescValid &&
          isVehicleYearFieldValid &&
          isVehicleMakeFieldValid &&
          isVehicleModelFieldValid;

      if (isVehicleYearFieldValid) {
        enableMakeField.value = true;
      } else {
        enableMakeField.value = false;
      }

      if (isVehicleMakeFieldValid) {
        enableModelField.value = true;
      } else {
        enableModelField.value = false;
      }

      if (widget.isNewDriverNotifier.value) {
        widget.isFormValid.value = commonValidations &&
            isDriverFirstNameFieldValid &&
            isDriverLastNameFieldValid &&
            isDriverLicenseNumberFieldValid;
      } else {
        widget.isFormValid.value = commonValidations;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DriversAndVehiclesHeader(),
        const SizedBox(
          height: kSpacingMedium,
        ),
        InsuredDriversBottomSheet(
          onChanged: (value) {
            if (value != context.getLocalizationOf.insuredDriverOtherLabel &&
                value is Driver) {
              widget.isNewDriverNotifier.value = false;
              widget.insuredDriverInfoNotifier.value =
                  widget.insuredDriverInfoNotifier.value.copyWith(
                name: SubmitClaimName(
                  firstName: value.firstName,
                  lastName: value.lastName,
                  displayName: value.fullName,
                ),
                licenseState: value.driversLicenseState,
                licenseNumber: value.driversLicenseNumber,
                dateOfBirth: value.dateOfBirth,
              );
            } else {
              widget.isNewDriverNotifier.value = true;
              widget.insuredDriverInfoNotifier.value = AutoPrimaryInsured(
                name: SubmitClaimName(
                  firstName: insuredDriverFirstName.text,
                  lastName: insuredDriverLastName.text,
                  displayName:
                      '${insuredDriverFirstName.text} ${insuredDriverLastName.text}',
                ),
                licenseState: insuredDriverLicenseState.text,
                licenseNumber: insuredDriverLicenseNumber.text,
              );
            }
            validateForm();
          },
          selectedValueController: insuredDriverFieldController,
          validator: insuredDriverValidator.validate,
        ),
        const SizedBox(height: kSpacingSmall),
        ValueListenableBuilder(
          valueListenable: widget.isNewDriverNotifier,
          builder: (
            context,
            isNewDriver,
            _,
          ) {
            return AnimatedSize(
              duration: animationDuration,
              reverseDuration: animationDuration,
              curve: Curves.easeInOut,
              child: isNewDriver
                  ? Column(
                      children: [
                        TfbDriverFirstName(
                          controller: insuredDriverFirstName,
                          onChanged: (value) {
                            widget.insuredDriverInfoNotifier.value =
                                widget.insuredDriverInfoNotifier.value.copyWith(
                              name: SubmitClaimName(
                                firstName: value,
                                lastName: insuredDriverLastName.text,
                                displayName:
                                    '$value ${insuredDriverLastName.text}',
                              ),
                            );
                            validateForm();
                          },
                        ),
                        const SizedBox(height: kSpacingSmall),
                        TfbDriverLastName(
                          controller: insuredDriverLastName,
                          onChanged: (value) {
                            widget.insuredDriverInfoNotifier.value =
                                widget.insuredDriverInfoNotifier.value.copyWith(
                              name: SubmitClaimName(
                                firstName: insuredDriverFirstName.text,
                                lastName: value,
                                displayName:
                                    '${insuredDriverFirstName.text} $value',
                              ),
                            );
                            validateForm();
                          },
                        ),
                        const SizedBox(height: kSpacingSmall),
                        TfbDriverLicenseNumber(
                          controller: insuredDriverLicenseNumber,
                          onChanged: (value) {
                            widget.insuredDriverInfoNotifier.value =
                                widget.insuredDriverInfoNotifier.value.copyWith(
                              licenseNumber: value,
                            );
                            validateForm();
                          },
                        ),
                        const SizedBox(height: kSpacingSmall),
                        LicenseStateBottomSheet(
                          onChanged: (value) {
                            widget.insuredDriverInfoNotifier.value =
                                widget.insuredDriverInfoNotifier.value.copyWith(
                              licenseState: value as String,
                            );
                            validateForm();
                          },
                          selectedValueController: insuredDriverLicenseState,
                        ),
                        const SizedBox(height: kSpacingSmall),
                      ],
                    )
                  : null,
            );
          },
        ),
        InsuredVehicleBottomSheet(
          onChanged: (value) {
            if (value is Vehicles) {
              widget.insuredVehicleInfoNotifier.value =
                  widget.insuredVehicleInfoNotifier.value.copyWith(
                id: value.id,
                licensePlate: value.licensePlate,
                seqNum: value.seqNum,
                externalIdValTxt: value.externalIdValTxt,
                address: value.address,
                year: value.year,
                make: value.make,
                model: value.model,
                vin: value.vin,
                bodyStyle: value.bodyStyle,
              );
            }
            validateForm();
          },
          selectedValueController: insuredVehicleFieldController,
          validator: insuredVehicleFormFieldValidator.validate,
        ),
        const SizedBox(
          height: kSpacingSmall,
        ),
        IsVehicleDrivable(
          textEditingController: isVehicleDrivableLocationController,
          yesNoValueNotifier: isVehicleDrivableValue,
          onChange: (String? value) {
            if (value == null) {
              widget.insuredVehicleInfoNotifier.value =
                  widget.insuredVehicleInfoNotifier.value.copyWith(
                isDriveable: 'Y',
                currentLocation: value,
              );
            } else {
              widget.insuredVehicleInfoNotifier.value =
                  widget.insuredVehicleInfoNotifier.value.copyWith(
                isDriveable: 'N',
                currentLocation: value,
              );
            }
            validateForm();
          },
        ),
        const SizedBox(
          height: kSpacingSmall,
        ),
        WasAnyoneInjured(
          textEditingController: describeInjuriesFieldController,
          yesNoValueNotifier: isAnyoneInjuredValue,
          onChange: (String? value) {
            if (value == null) {
              widget.insuredDriverInfoNotifier.value =
                  widget.insuredDriverInfoNotifier.value.copyWith(
                injuryInd: 'N',
                injuryDescription: value,
              );
            } else {
              widget.insuredDriverInfoNotifier.value =
                  widget.insuredDriverInfoNotifier.value.copyWith(
                injuryInd: 'Y',
                injuryDescription: value,
              );
            }
            validateForm();
          },
        ),
        const SizedBox(
          height: kSpacingSmall,
        ),
        WasAnotherPartyInvolved(
          yesNoValueNotifier: isAnotherPartyInvolvedValue,
          onChange: (value) {
            if (value == YesNoButtonKind.no) {
              widget.thirdPartyDriverInfoNotifier.value = null;
              widget.thirdPartyVehicleInfoNotifier.value = null;
            } else {
              widget.thirdPartyDriverInfoNotifier.value = AutoPrimaryInsured(
                name: SubmitClaimName(
                  firstName: involvedDriverFirstName.text,
                  lastName: involvedDriverLastName.text,
                  displayName:
                      '$involvedDriverFirstName $involvedDriverLastName',
                ),
                address: SubmitClaimAddress(
                  addressLine1: involvedDriverStreetAddress.text,
                  city: involvedDriverCity.text,
                  state: involvedDriverState.text,
                  zip: involvedDriverZipCode.text,
                ),
                phone: involvedDriverPhone.text,
                licenseNumber: involvedDriverLicenseNumber.text,
                licenseState: involvedDriverLicenseState.text,
                injuryInd:
                    isInvolvedVehicleDrivableValue.value == YesNoButtonKind.yes
                        ? 'Y'
                        : 'N',
                injuryDescription:
                    isInvolvedVehicleDrivableValue.value == YesNoButtonKind.yes
                        ? describeInvolvedInjuriesFieldController.text
                        : null,
              );
              widget.thirdPartyVehicleInfoNotifier.value = SubmitClaimVehicle(
                year: vehicleYearFieldController.text,
                make: vehicleMakeFieldController.text,
                model: vehicleModelFieldController.text,
                licensePlate: involvedVehicleLicensePlateNumber.text,
                licensePlateState: involvedVehicleLicensePlateState.text,
                ownerInformation: OwnerInformation(
                  firstName: involvedVehicleOwnerFirstName.text,
                  lastName: involvedVehicleOwnerLastName.text,
                ),
              );
            }
            validateForm();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: kSpacingMedium),
                child: Text(
                  context.getLocalizationOf.anotherPartyDriverTitle,
                  style: context.tfbText.bodyRegularLarge.copyWith(
                    color: TfbBrandColors.grayHighest,
                  ),
                ),
              ),
              TfbInvolvedDriverFirstName(
                controller: involvedDriverFirstName,
                onChanged: (value) {
                  widget.thirdPartyDriverInfoNotifier.value?.copyWith(
                    name: SubmitClaimName(
                      firstName: value,
                      lastName: involvedDriverLastName.text,
                      displayName: '$value $involvedDriverLastName',
                    ),
                  );
                  validateForm();
                },
              ),
              const SizedBox(height: kSpacingSmall),
              TfbInvolvedDriverLastName(
                controller: involvedDriverLastName,
                onChanged: (value) {
                  widget.thirdPartyDriverInfoNotifier.value?.copyWith(
                    name: SubmitClaimName(
                      firstName: involvedDriverFirstName.text,
                      lastName: value,
                      displayName: '${involvedDriverFirstName.text} $value',
                    ),
                  );
                  validateForm();
                },
              ),
              const SizedBox(height: kSpacingSmall),
              TfbStreetAddress(
                controller: involvedDriverStreetAddress,
                onChanged: (value) {
                  widget.thirdPartyDriverInfoNotifier.value?.copyWith(
                    address: SubmitClaimAddress(
                      addressLine1: value,
                      city: involvedDriverCity.text,
                      state: involvedDriverState.text,
                      zip: involvedDriverZipCode.text,
                    ),
                  );
                  validateForm();
                },
              ),
              const SizedBox(height: kSpacingSmall),
              StateBottomSheet(
                onChanged: (value) {
                  widget.thirdPartyDriverInfoNotifier.value?.copyWith(
                    address: SubmitClaimAddress(
                      addressLine1: involvedDriverStreetAddress.text,
                      city: involvedDriverCity.text,
                      state: value as String,
                      zip: involvedDriverZipCode.text,
                    ),
                  );
                  validateForm();
                },
                selectedValueController: involvedDriverState,
                isRequired: false,
              ),
              const SizedBox(height: kSpacingSmall),
              CityFormField(
                controller: involvedDriverCity,
                onChanged: (value) {
                  widget.thirdPartyDriverInfoNotifier.value?.copyWith(
                    address: SubmitClaimAddress(
                      addressLine1: involvedDriverStreetAddress.text,
                      city: value,
                      state: involvedDriverState.text,
                      zip: involvedDriverZipCode.text,
                    ),
                  );
                  validateForm();
                },
                isRequired: false,
              ),
              const SizedBox(height: kSpacingSmall),
              TfbZipCode(
                controller: involvedDriverZipCode,
                onChanged: (value) {
                  widget.thirdPartyDriverInfoNotifier.value?.copyWith(
                    address: SubmitClaimAddress(
                      addressLine1: involvedDriverStreetAddress.text,
                      city: involvedDriverCity.text,
                      state: involvedDriverState.text,
                      zip: value,
                    ),
                  );
                  validateForm();
                },
              ),
              const SizedBox(height: kSpacingSmall),
              ContactPhoneNumberFormField(
                label: context.getLocalizationOf.phoneNumberTextFormField,
                controller: involvedDriverPhone,
                onChanged: (value) {
                  widget.thirdPartyDriverInfoNotifier.value =
                      widget.thirdPartyDriverInfoNotifier.value?.copyWith(
                    phone: value,
                  );
                  validateForm();
                },
                isRequired: false,
              ),
              const SizedBox(height: kSpacingSmall),
              TfbDriverLicenseNumber(
                controller: involvedDriverLicenseNumber,
                onChanged: (value) {
                  widget.thirdPartyDriverInfoNotifier.value =
                      widget.thirdPartyDriverInfoNotifier.value?.copyWith(
                    licenseNumber: value,
                  );
                  validateForm();
                },
              ),
              const SizedBox(height: kSpacingSmall),
              LicenseStateBottomSheet(
                selectedValueController: involvedDriverLicenseState,
                onChanged: (value) {
                  widget.thirdPartyDriverInfoNotifier.value =
                      widget.thirdPartyDriverInfoNotifier.value?.copyWith(
                    licenseState: value as String,
                  );
                  validateForm();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: kSpacingLarge,
                  bottom: kSpacingMedium,
                ),
                child: Text(
                  context.getLocalizationOf.anotherPartyVehicleTitle,
                  style: context.tfbText.bodyRegularLarge.copyWith(
                    color: TfbBrandColors.grayHighest,
                  ),
                ),
              ),
              VehicleYearBottomSheet(
                selectedValueController: vehicleYearFieldController,
                onChanged: (value) {
                  vehicleMakeFieldController.text = '';
                  vehicleModelFieldController.text = '';
                  enableModelField.value = false;
                  enableMakeField.value = false;
                  widget.thirdPartyVehicleInfoNotifier.value =
                      widget.thirdPartyVehicleInfoNotifier.value?.copyWith(
                    year: value as String,
                  );
                  validateForm();
                },
              ),
              const SizedBox(height: kSpacingSmall),
              ListenableBuilder(
                listenable: enableMakeField,
                builder: (BuildContext context, Widget? child) {
                  return VehicleMakeSelector(
                    selectedValueController: vehicleMakeFieldController,
                    onVehicleMakeSelected: (SubmitClaimVehicleMake? value) {
                      vehicleModelFieldController.text = '';
                      widget.thirdPartyVehicleInfoNotifier.value =
                          widget.thirdPartyVehicleInfoNotifier.value?.copyWith(
                        make: value!.key,
                      );
                      validateForm();
                    },
                    isEnabled: enableMakeField.value,
                    year: vehicleYearFieldController.text,
                  );
                },
              ),
              const SizedBox(height: kSpacingSmall),
              ListenableBuilder(
                listenable: enableModelField,
                builder: (BuildContext context, Widget? child) {
                  return VehicleModelSelector(
                    selectedValueController: vehicleModelFieldController,
                    onVehicleMakeSelected: (VehicleModelResponse? value) {
                      widget.thirdPartyVehicleInfoNotifier.value =
                          widget.thirdPartyVehicleInfoNotifier.value?.copyWith(
                        model: value!.key,
                      );
                      validateForm();
                    },
                    isEnabled: enableModelField.value,
                    modelRequest: VehicleModelRequest(
                      year: vehicleYearFieldController.text,
                      make: vehicleMakeFieldController.text,
                    ),
                  );
                },
              ),
              const SizedBox(height: kSpacingSmall),
              TfbInvolvedVehiclePlateNumber(
                controller: involvedVehicleLicensePlateNumber,
                onChanged: (value) {
                  widget.thirdPartyVehicleInfoNotifier.value = widget
                      .thirdPartyVehicleInfoNotifier.value
                      ?.copyWith(licensePlate: value);
                  validateForm();
                },
              ),
              const SizedBox(height: kSpacingSmall),
              TfbInvolvedVehiclePlateState(
                selectedValueController: involvedVehicleLicensePlateState,
                onChanged: (value) {
                  widget.thirdPartyVehicleInfoNotifier.value = widget
                      .thirdPartyVehicleInfoNotifier.value
                      ?.copyWith(licensePlateState: value);
                  validateForm();
                },
              ),
              const SizedBox(height: kSpacingSmall),
              TfbOwnerFirstName(
                controller: involvedVehicleOwnerFirstName,
                onChanged: (value) {
                  widget.thirdPartyVehicleInfoNotifier.value =
                      widget.thirdPartyVehicleInfoNotifier.value?.copyWith(
                    ownerInformation: OwnerInformation(
                      firstName: value,
                      lastName: involvedVehicleOwnerLastName.text,
                    ),
                  );
                  validateForm();
                },
              ),
              const SizedBox(height: kSpacingSmall),
              TfbOwnerLastName(
                controller: involvedVehicleOwnerLastName,
                onChanged: (value) {
                  widget.thirdPartyVehicleInfoNotifier.value =
                      widget.thirdPartyVehicleInfoNotifier.value?.copyWith(
                    ownerInformation: OwnerInformation(
                      firstName: involvedVehicleOwnerFirstName.text,
                      lastName: value,
                    ),
                  );
                  validateForm();
                },
              ),
              const SizedBox(
                height: kSpacingSmall,
              ),
              IsVehicleDrivable(
                textEditingController:
                    isInvolvedVehicleDrivableLocationController,
                yesNoValueNotifier: isInvolvedVehicleDrivableValue,
                onChange: (String? value) {
                  if (value == null) {
                    widget.thirdPartyVehicleInfoNotifier.value =
                        widget.thirdPartyVehicleInfoNotifier.value?.copyWith(
                      isDriveable: 'Y',
                      currentLocation: value,
                    );
                  } else {
                    widget.thirdPartyVehicleInfoNotifier.value =
                        widget.thirdPartyVehicleInfoNotifier.value?.copyWith(
                      isDriveable: 'N',
                      currentLocation: value,
                    );
                  }
                  validateForm();
                },
              ),
              const SizedBox(
                height: kSpacingSmall,
              ),
              WasAnyoneInjured(
                textEditingController: describeInvolvedInjuriesFieldController,
                yesNoValueNotifier: isAnyoneInvolvedInjuredValue,
                onChange: (String? value) {
                  if (value == null) {
                    widget.thirdPartyDriverInfoNotifier.value =
                        widget.thirdPartyDriverInfoNotifier.value?.copyWith(
                      injuryInd: 'N',
                      injuryDescription: value,
                    );
                  } else {
                    widget.thirdPartyDriverInfoNotifier.value =
                        widget.thirdPartyDriverInfoNotifier.value?.copyWith(
                      injuryInd: 'Y',
                      injuryDescription: value,
                    );
                  }
                  validateForm();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
