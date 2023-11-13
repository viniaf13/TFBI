import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/update_email/update_email_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/account_email_text_field.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_email_validator.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/update_email_request.dart';
import 'package:txfb_insurance_flutter/shared/extensions/focus_extension.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_field_semantics_wrapper.dart';

class UpdateEmailForm extends StatelessWidget {
  const UpdateEmailForm({
    required this.emailController,
    required this.emailValidator,
    required this.isEmailValidNotifier,
    super.key,
  });

  final TextEditingController emailController;
  final TfbEmailValidator emailValidator;
  final ValueNotifier<bool> isEmailValidNotifier;

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Form(
        child: Column(
          children: [
            TextFieldSemanticsWrapper(
              label: context.getLocalizationOf.inputField(
                context.getLocalizationOf.emailLabel,
              ),
              child: AccountEmailTextField(
                controller: emailController,
                onChanged: (value) {
                  isEmailValidNotifier.value =
                      emailValidator.validate(emailController.text) == null;
                },
                validator: emailValidator,
              ),
            ),
            ValueListenableBuilder(
              valueListenable: isEmailValidNotifier,
              builder: (context, isEmailValid, child) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: kSpacingMedium,
                  ),
                  child: TfbFilledButton.primaryTextButton(
                    onPressed:
                        isEmailValid ? () => submitUpdatedEmail(context) : null,
                    title: context.getLocalizationOf.updateEmailCTA,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void submitUpdatedEmail(BuildContext context) {
    BlocProvider.of<UpdateEmailCubit>(
      context,
    ).request(
      fallbackRequest: () async {
        context.dismissCurrentFocus();
        return context.read<TfbMemberAccessClient>().updateEmail(
              UpdateEmailRequest.fromContext(
                context,
                emailController.text,
              ),
            );
      },
    );
  }
}
