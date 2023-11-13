import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/change_password/change_password_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/create_account/widgets/register_account_widgets.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_confirm_password_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_password_registration_validator.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/mixins/full_screen_loading_overlay_mixin.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_animated_app_bar.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_dropshadow_scroll_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({
    super.key,
  });

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with FullScreenLoadingOverlay {
  final passwordFormField = TextEditingController();
  final confirmPasswordFormField = TextEditingController();
  final isValidated = ValueNotifier(false);

  void handleChangePasswordState(
    ChangePasswordState state,
    BuildContext context,
  ) {
    hideFullscreenLoadingOverlay();

    if (state is ChangePasswordSuccess) {
      context.navigator.goToChangePasswordSuccessPage();
    } else if (state is ChangePasswordFailure) {
      context.showErrorSnackBar(text: state.error.message);
    } else if (state is ChangePasswordProcessing) {
      showFullscreenLoadingOverlay(preventPop: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final passwordValidator = TfbRegistrationPasswordValidator();
    final confirmPasswordValidator = TfbConfirmPasswordValidator.localized(
      passwordFormField,
      confirmPasswordFormField,
      context,
    );

    void validatePasswords() => isValidated.value =
        (confirmPasswordValidator.validate(confirmPasswordFormField.text) ==
                null) &&
            (passwordValidator.validate(passwordFormField.text).isEmpty);

    return ScaffoldMessenger(
      child: Scaffold(
        appBar: TfbAnimatedAppBar(
          onCancelPressed: () => context.navigator.router.pop(),
          showCancelButton: true,
          automaticallyImplyLeading: false,
          titleString: context.getLocalizationOf.changePassword,
          backgroundColor: TfbBrandColors.grayLow,
        ),
        body: GradientBackground(
          gradient: LightColors.authenticationBackgroundGradient,
          child: ScrollableViewWithPinnedButton(
            button: ValueListenableBuilder(
              valueListenable: isValidated,
              builder: (context, isValid, _) {
                return TfbFilledButton.primaryTextButton(
                  title: context.getLocalizationOf.changePassword,
                  onPressed: isValid
                      ? () {
                          context
                              .read<ChangePasswordCubit>()
                              .submitChangedPassword(
                                ChangePasswordSubmission(
                                  membershipArray: context.user?.members
                                          ?.map((e) => e.memberNumber)
                                          .toList() ??
                                      [],
                                  emailAddress:
                                      context.user?.memberEmailAddress ?? '',
                                  password: passwordFormField.text,
                                ),
                              );
                        }
                      : null,
                );
              },
            ),
            child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
              listener: (context, state) =>
                  handleChangePasswordState(state, context),
              child: TfbDropShadowScrollWidget(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kSpacingExtraLarge,
                  ),
                  child: ListView(
                    children: [
                      Text(
                        context.getLocalizationOf.changePassword,
                        style: context.tfbText.header3.copyWith(
                          color: TfbBrandColors.blueHighest,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: kSpacingMedium),
                        child: Text(
                          context.getLocalizationOf.updatePasswordPrompt,
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
