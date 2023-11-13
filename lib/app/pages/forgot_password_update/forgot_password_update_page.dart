import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/forgot_password_verify/forgot_password_verify_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/create_account/widgets/register_password_criteria.dart';
import 'package:txfb_insurance_flutter/app/pages/create_account/widgets/register_password_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/forgot_password_update/update_password_button.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_confirm_password_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_password_registration_validator.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/processing_snackbar_icon.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_never_pop.dart';

class ForgotPasswordUpdatePage extends StatefulWidget {
  ForgotPasswordUpdatePage({
    required this.resetToken,
    required this.resetEmail,
    super.key,
  });

  final String? resetToken;
  final String? resetEmail;
  final isValidated = ValueNotifier(false);

  @override
  State<ForgotPasswordUpdatePage> createState() =>
      _ForgotPasswordUpdatePageState();
}

class _ForgotPasswordUpdatePageState extends State<ForgotPasswordUpdatePage> {
  @override
  Widget build(BuildContext context) {
    final passwordFormField = TextEditingController();
    final confirmPasswordFormField = TextEditingController();
    final passwordValidator = TfbRegistrationPasswordValidator();
    final confirmPasswordValidator = TfbConfirmPasswordValidator.localized(
      passwordFormField,
      confirmPasswordFormField,
      context,
    );

    void validatePasswords() => widget.isValidated.value =
        (confirmPasswordValidator.validate(confirmPasswordFormField.text) ==
                null) &&
            (passwordValidator.validate(passwordFormField.text).isEmpty);

    return TfbNeverPop(
      child: ScaffoldMessenger(
        child: Scaffold(
          appBar: TfbAppBar(onCancelPressed: context.navigator.goToLoginPage),
          extendBodyBehindAppBar: true,
          body: GradientBackground(
            gradient: LightColors.authenticationBackgroundGradient,
            child: ScrollableViewWithPinnedButton(
              button: BlocBuilder<ForgotPasswordVerifyCubit,
                  ForgotPasswordVerifyState>(
                builder: (context, state) {
                  return ValueListenableBuilder<bool>(
                    valueListenable: widget.isValidated,
                    builder: (context, isValidated, _) {
                      return UpdatePasswordButton(
                        isValidated: widget.isValidated.value,
                        isProcessing: state is ForgotPasswordVerifyProcessing,
                        onPressed: () => (widget.resetToken != null &&
                                widget.resetEmail != null)
                            ? context
                                .read<ForgotPasswordVerifyCubit>()
                                .submitUpdatedPassword(
                                  UpdatedPasswordSubmission(
                                    emailAddress: widget.resetEmail!,
                                    verificationCode: widget.resetToken!,
                                    password: passwordFormField.text,
                                  ),
                                )
                            : context.showErrorSnackBar(
                                text: context.getLocalizationOf.unexpectedError,
                              ),
                      );
                    },
                  );
                },
              ),
              child: BlocListener<ForgotPasswordVerifyCubit,
                  ForgotPasswordVerifyState>(
                listener: (context, state) =>
                    handleForgotPasswordState(state, context),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kSpacingLarge),
                  child: ListView(
                    children: [
                      Text(
                        context.getLocalizationOf.accountVerified,
                        style: context.tfbText.header3.copyWith(
                          color: TfbBrandColors.blueHighest,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: kSpacingSmall),
                        child: Text(
                          context.getLocalizationOf.forgotPasswordSubtitle,
                          style: context.tfbText.bodyRegularLarge,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: kSpacingMedium),
                        child: RegisterPasswordFormField(
                          registerPasswordController: passwordFormField,
                          labelText: context.getLocalizationOf.newPassword,
                          onChanged: (_) {
                            passwordValidator.validate(passwordFormField.text);
                            validatePasswords();
                          },
                        ),
                      ),
                      PasswordCriteria(passwordController: passwordFormField),
                      RegisterPasswordFormField(
                        registerPasswordController: confirmPasswordFormField,
                        labelText: context.getLocalizationOf.confirmNewPassword,
                        validator: confirmPasswordValidator.validate,
                        onChanged: (_) => validatePasswords(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void handleForgotPasswordState(
  ForgotPasswordVerifyState state,
  BuildContext context,
) {
  if (state is ForgotPasswordVerifySuccess) {
    context.navigator.goToForgotPasswordUpdateSuccessPage();
  } else if (state is ForgotPasswordVerifyFailure) {
    context.showErrorSnackBar(text: state.error.message);
  } else if (state is ForgotPasswordVerifyProcessing) {
    context.showProcessingSnackBar(
      text: kRequestProcessingLabel,
      icon: const ProcessingSnackbarIcon(),
    );
  } else {
    return;
  }
}
