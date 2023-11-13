import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/contact_phone_number_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/contact_type_bottom_sheet.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/reporter_info_section/bottom_sheet_reporter_type.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/reporter_info_section/email_address_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/reporter_info_section/name_form_field.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_email_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_initials_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_phone_number_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_required_field_validator.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/enum/phone_types_enum.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_reporter_info.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class ReporterInfoSection extends StatefulWidget {
  const ReporterInfoSection({
    required this.isFormValid,
    required this.insuredName,
    required this.reporterInfoNotifier,
    super.key,
  });

  final ValueNotifier<bool> isFormValid;
  final String insuredName;
  final ValueNotifier<ReporterInformation> reporterInfoNotifier;

  @override
  State<ReporterInfoSection> createState() => _ReporterInfoSectionState();
}

class _ReporterInfoSectionState extends State<ReporterInfoSection> {
  late TextEditingController nameFieldController;
  late TextEditingController reporterTypeFieldController;
  late TextEditingController phoneNumberFieldController;
  late TextEditingController emailAddressFieldController;
  late TextEditingController contactTypeFieldController;

  @override
  Widget build(BuildContext context) {
    nameFieldController = TextEditingController(
      text: widget.insuredName,
    );
    reporterTypeFieldController = TextEditingController(
      text: widget.reporterInfoNotifier.value.reporterType,
    );
    phoneNumberFieldController = TextEditingController(
      text: widget.reporterInfoNotifier.value.phoneNumber,
    );
    emailAddressFieldController = TextEditingController(
      text: widget.reporterInfoNotifier.value.emailAddress,
    );
    contactTypeFieldController = TextEditingController(
      text: PhoneTypesEnum.getUiValueFromValue(
        widget.reporterInfoNotifier.value.phoneType,
      ),
    );

    widget.reporterInfoNotifier.value =
        widget.reporterInfoNotifier.value.copyWith(
      name: widget.insuredName,
    );

    final nameFormFieldValidator = TfbInitialsValidator.localized(context);
    final reporterTypeFormFieldValidator = TfbRequiredFieldValidator.localized(
      context,
      context.getLocalizationOf.reporterTypeTextFormField,
      TfbFieldType.typeable,
    );
    final phoneNumberFormFieldValidator =
        TfbPhoneNumberValidator.localized(context);
    final contactTypeFormFieldValidator = TfbRequiredFieldValidator.localized(
      context,
      context.getLocalizationOf.contactTypeFieldName,
      TfbFieldType.selectable,
    );
    final emailFormFieldValidator =
        TfbEmailValidator.localizedFileAClaimForm(context);

    void validateForm() {
      final isNameFieldValid =
          nameFormFieldValidator.validate(nameFieldController.text) == null;
      final isReporterTypeFieldValid = reporterTypeFormFieldValidator
              .validate(reporterTypeFieldController.text) ==
          null;
      final isPhoneNumberFieldValid = phoneNumberFormFieldValidator
              .validate(phoneNumberFieldController.text) ==
          null;
      final isContactTypeValid = contactTypeFormFieldValidator
              .validate(contactTypeFieldController.text) ==
          null;
      final isEmailFieldValid = emailAddressFieldController
              .text.isNullOrEmpty ||
          emailFormFieldValidator.validate(emailAddressFieldController.text) ==
              null;

      widget.isFormValid.value = isNameFieldValid &&
          isReporterTypeFieldValid &&
          isPhoneNumberFieldValid &&
          isContactTypeValid &&
          isEmailFieldValid;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          container: true,
          label: context.getLocalizationOf.reporterInformationTitle,
          child: Text(
            context.getLocalizationOf.reporterInformationTitle,
            style: context.tfbText.subHeaderRegular
                .copyWith(color: TfbBrandColors.blueHighest),
          ),
        ),
        const SizedBox(
          height: kSpacingMedium,
        ),
        NameFormField(
          controller: nameFieldController,
          onChanged: (value) {
            widget.reporterInfoNotifier.value =
                widget.reporterInfoNotifier.value.copyWith(
              name: value,
            );
            validateForm();
          },
        ),
        const SizedBox(
          height: kSpacingSmall,
        ),
        BottomSheetReporterType(
          onChanged: (value) {
            widget.reporterInfoNotifier.value =
                widget.reporterInfoNotifier.value.copyWith(
              reporterType: value as String,
            );
            validateForm();
          },
          selectedValueController: reporterTypeFieldController,
          validator: reporterTypeFormFieldValidator.validate,
        ),
        const SizedBox(
          height: kSpacingSmall,
        ),
        ContactPhoneNumberFormField(
          label: context.getLocalizationOf.phoneNumberTextFormField,
          controller: phoneNumberFieldController,
          onChanged: (value) {
            widget.reporterInfoNotifier.value =
                widget.reporterInfoNotifier.value.copyWith(
              phoneNumber: value,
            );
            validateForm();
          },
        ),
        const SizedBox(
          height: kSpacingSmall,
        ),
        ContactTypeBottomSheet(
          onChanged: (value) {
            widget.reporterInfoNotifier.value =
                widget.reporterInfoNotifier.value.copyWith(
              phoneType: value as String,
            );
            validateForm();
          },
          selectedValueController: contactTypeFieldController,
          title: context.getLocalizationOf.contactType,
          validator: contactTypeFormFieldValidator.validate,
        ),
        const SizedBox(
          height: kSpacingSmall,
        ),
        EmailAddressFormField(
          controller: emailAddressFieldController,
          onChanged: (value) {
            widget.reporterInfoNotifier.value =
                widget.reporterInfoNotifier.value.copyWith(
              emailAddress: value,
            );
            validateForm();
          },
        ),
      ],
    );
  }
}
