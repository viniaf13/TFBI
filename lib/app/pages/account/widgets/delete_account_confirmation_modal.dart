import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/delete_account/delete_account_cubit.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_initials_validator.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/delete_account_request.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_field_semantics_wrapper.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class DeleteAccountConfirmationModal extends StatefulWidget {
  const DeleteAccountConfirmationModal({super.key});

  @override
  State<DeleteAccountConfirmationModal> createState() =>
      _DeleteAccountConfirmationModalState();
}

class _DeleteAccountConfirmationModalState
    extends State<DeleteAccountConfirmationModal> {
  bool isValid = false;
  final textEditingController = TextEditingController();
  TfbInitialsValidator? initialsValidator;

  void validateForm() {
    final areInitialsValid =
        initialsValidator?.validate(textEditingController.text) == null;

    if (areInitialsValid != isValid) {
      setState(() {
        isValid = areInitialsValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    initialsValidator ??= TfbInitialsValidator.localized(context);

    final currentUser = context.user;
    // As of June 26 2023, Stephanie on TXFB side said it doesn't matter which
    // member is used to delete an account, so just pulling the first one.
    final currentMember = currentUser?.members?.first;
    final accessToken = context.tfbUserAccessToken;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: context.radii.defaultRadius,
      ),
      contentPadding: const EdgeInsets.only(
        bottom: 5,
        left: 16,
        right: 16,
        top: 16,
      ),
      backgroundColor: LightColors.background,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: kSpacingSmall),
            child: Text(
              context.getLocalizationOf.deleteModalTitle,
              style: context.tfbText.header3.copyWith(
                color: TfbBrandColors.blueHighest,
              ),
            ),
          ),
          Text(
            context.getLocalizationOf.deleteModalSubtitle,
            style: context.tfbText.bodyRegularLarge,
          ),
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFieldSemanticsWrapper(
              label: context.getLocalizationOf.inputField(
                context.getLocalizationOf.initialsFieldLabel,
              ),
              child: TextFormField(
                textCapitalization: TextCapitalization.characters,
                controller: textEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: context.getLocalizationOf.initialsFieldLabel,
                ),
                validator: initialsValidator?.validate,
                autofocus: true,
                onChanged: (_) => validateForm(),
                onEditingComplete: validateForm,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: kSpacingLarge),
            child: SizedBox(
              width: double.infinity,
              child: TfbFilledButton.primaryTextButton(
                onPressed: !isValid
                    ? null
                    : () {
                        if (currentMember != null && accessToken != null) {
                          context.read<DeleteAccountCubit>().deleteAccount(
                                DeleteAccountRequest(
                                  memberId: currentMember.memberIDNumber,
                                  memberInitials: textEditingController.text,
                                  memberNumber: currentMember.memberNumber,
                                ),
                              );
                        } else {
                          TfbLogger.verbose(
                            currentUser?.members?.toString() ?? '',
                          );
                          context.showErrorSnackBar(
                            text: 'No member found...',
                          );
                        }
                      },
                title: context.getLocalizationOf.deleteModalConfirm,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: kSpacingSmall),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    context.getLocalizationOf.cancelButtonTitle,
                    style: context.tfbText.bodyMediumSmall.copyWith(
                      color: TfbBrandColors.blueHighest,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
