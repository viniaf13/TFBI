import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/autopay_enrollment/routing_number_validation_cubit.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/account_info_form_data.dart';
import 'package:txfb_insurance_flutter/shared/enum/form_validation_type.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';
import 'package:txfb_insurance_flutter/shared/widgets/validating_form_field.dart';

class AccountInfoForm extends StatefulWidget {
  const AccountInfoForm({
    required this.formKey,
    required this.isFormValid,
    required this.accountInfoData,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final ValueNotifier<bool> isFormValid;
  final ValueNotifier<AccountInfoFormData> accountInfoData;

  @override
  State<AccountInfoForm> createState() => _AccountInfoFormState();
}

class _AccountInfoFormState extends State<AccountInfoForm> {
  TextEditingController bankNameController = TextEditingController();
  TextEditingController routingNumberController = TextEditingController();
  TextEditingController bankAccountNameController = TextEditingController();
  TextEditingController bankAccountNumberController = TextEditingController();
  TextEditingController confirmBankAccountNumberController =
      TextEditingController();

  @override
  void initState() {
    bankNameController.text = widget.accountInfoData.value.bankAccountName;
    routingNumberController.text = widget.accountInfoData.value.routingNumber;
    bankAccountNameController.text = context.user?.memberName ?? '';
    confirmBankAccountNumberController.text =
        widget.accountInfoData.value.bankAccountNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void validateForm() {
      String? validateWithContext({
        required String value,
        required ValidationType type,
      }) =>
          validateWithValidationType(
            value: value,
            type: type,
            context: context,
            // Don't need any label text since we're just checking if we get
            // a value back, not displaying to user.
            labelText: '',
          );

      widget.isFormValid.value = validateWithContext(
            value: routingNumberController.text,
            type: ValidationType.bankRoutingNumber,
          ).isNullOrEmpty &&
          validateWithContext(
            value: bankNameController.text,
            type: ValidationType.bankName,
          ).isNullOrEmpty &&
          validateWithContext(
            value: bankAccountNameController.text,
            type: ValidationType.bankAccountName,
          ).isNullOrEmpty &&
          validateWithContext(
            value: bankAccountNumberController.text,
            type: ValidationType.bankAccountNumber,
          ).isNullOrEmpty &&
          validateWithContext(
            value: confirmBankAccountNumberController.text,
            type: ValidationType.bankAccountNumber,
          ).isNullOrEmpty &&
          bankAccountNumberController.text ==
              confirmBankAccountNumberController.text;

      widget.accountInfoData.value = AccountInfoFormData(
        bankAccountName: bankAccountNumberController.text,
        routingNumber: routingNumberController.text,
        bankAccountNumber: bankAccountNumberController.text,
        bankName: bankNameController.text,
      );
    }

    return BlocConsumer<RoutingValidationCubit, RoutingValidationState>(
      listener: (context, state) {
        if (state is RoutingValidationSuccessState) {
          bankNameController.text = state.response;
          validateForm();
        } else {
          bankNameController.clear();
        }
      },
      builder: (context, state) => Form(
        key: widget.formKey,
        child: Column(
          children: [
            FocusScope(
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  context
                      .read<RoutingValidationCubit>()
                      .validateRoutingNumber(routingNumberController.text);
                }
              },
              child: ValidatingFormField(
                initialValue: widget.accountInfoData.value.routingNumber,
                labelText: context.getLocalizationOf.autopayRoutingNumberLabel,
                semanticsLabel: context.getLocalizationOf.inputField(
                  context.getLocalizationOf.autopayRoutingNumberLabel,
                ),
                type: ValidationType.bankRoutingNumber,
                isRequired: true,
                controller: routingNumberController,
                onChanged: (value) {
                  BlocProvider.of<RoutingValidationCubit>(context).reset();
                  validateForm();
                },
                additionalValidator: (_) => isRoutingInvalid(
                  state: state,
                  bankName: bankNameController.text,
                  routing: routingNumberController.text,
                )
                    ? context.getLocalizationOf.routingNumberError
                    : null,
              ),
            ),
            const SizedBox(
              height: kSpacingSmall,
            ),
            ValueListenableBuilder(
              valueListenable: bankNameController,
              builder: (context, bankName, child) {
                return Opacity(
                  opacity: bankName.text.isNullOrEmpty ? 0.5 : 1.0,
                  child: ValidatingFormField(
                    labelText: context.getLocalizationOf.autopayBankNameLabel,
                    semanticsLabel: context.getLocalizationOf.inputField(
                      context.getLocalizationOf.autopayBankNameLabel,
                    ),
                    isEnabled: false,
                    type: ValidationType.bankName,
                    controller: bankNameController,
                    onChanged: (value) => validateForm(),
                    suffixIcon: Opacity(
                      opacity:
                          state is RoutingValidationProcessingState ? 1.0 : 0,
                      child: const TfbBrandLoadingIcon(
                        thickness: LoadingOverlayThickness.thick,
                      ),
                    ),
                    suffixIconConstraints: const BoxConstraints(
                      maxHeight: 24,
                      maxWidth: 24,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: kSpacingSmall,
            ),
            ValidatingFormField(
              labelText:
                  context.getLocalizationOf.autopayNameOnBankAccountLabel,
              semanticsLabel: context.getLocalizationOf.inputField(
                context.getLocalizationOf.autopayNameOnBankAccountLabel,
              ),
              type: ValidationType.bankAccountName,
              isRequired: true,
              controller: bankAccountNameController,
              onChanged: (value) => validateForm(),
            ),
            const SizedBox(
              height: kSpacingSmall,
            ),
            ValidatingFormField(
              labelText:
                  context.getLocalizationOf.autopayBankAccountNumberLabel,
              semanticsLabel: context.getLocalizationOf.inputField(
                context.getLocalizationOf.autopayBankAccountNumberLabel,
              ),
              type: ValidationType.bankAccountNumber,
              isRequired: true,
              controller: bankAccountNumberController,
              onChanged: (value) => validateForm(),
            ),
            const SizedBox(
              height: kSpacingSmall,
            ),
            ValidatingFormField(
              labelText: context
                  .getLocalizationOf.autopayConfirmBankAccountNumberLabel,
              semanticsLabel: context.getLocalizationOf.inputField(
                context.getLocalizationOf.autopayConfirmBankAccountNumberLabel,
              ),
              type: ValidationType.bankAccountNumber,
              isRequired: true,
              controller: confirmBankAccountNumberController,
              onChanged: (value) => validateForm(),
              additionalValidator: (value) {
                if (bankAccountNumberController.text !=
                    confirmBankAccountNumberController.text) {
                  return context
                      .getLocalizationOf.autopayAccountNumberMatchError;
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  bool isRoutingInvalid({
    required RoutingValidationState state,
    required String bankName,
    required String routing,
  }) =>
      state is RoutingValidationSuccessState &&
      bankName.isEmpty &&
      routing.length == 9;
}
