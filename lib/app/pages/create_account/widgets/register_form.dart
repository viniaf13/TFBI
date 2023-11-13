import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/registration/registration_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/create_account/widgets/register_account_widgets.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/data/data_validators/data_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_confirm_email_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_confirm_password_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_email_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_member_number_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_password_registration_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_policy_number_validator.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/secure_registration_request.dart';
import 'package:txfb_insurance_flutter/domain/models/registration/registration_resend_request.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/constants/spacing.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    required this.formKey,
    required this.isFormValid,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final ValueNotifier<bool> isFormValid;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late TextEditingController policyNumController;
  late TextEditingController memberNumController;
  late TextEditingController registerEmailController;
  late TextEditingController confirmEmailController;
  late TextEditingController registerPasswordController;
  late TextEditingController confirmPasswordController;
  late GlobalKey<FormState> formKey;
  bool termsChecked = false;

  @override
  void initState() {
    super.initState();
    policyNumController = TextEditingController();
    memberNumController = TextEditingController();
    registerEmailController = TextEditingController();
    confirmEmailController = TextEditingController();
    registerPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    /// Create all data validators for this form
    final confirmEmailValidator = TfbConfirmEmailValidator.localized(
      registerEmailController,
      confirmEmailController,
      context,
    );
    final passwordValidator = TfbRegistrationPasswordValidator();
    final confirmPasswordValidator = TfbConfirmPasswordValidator.localized(
      registerPasswordController,
      confirmPasswordController,
      context,
    );
    final policyNumberValidator = TfbPolicyNumberValidator.localized(context);
    final memberNumberValidator = TfbMemberNumberValidator.localized(context);
    final emailValidator = TfbEmailValidator.localizedRegistration(context);

    /// Confirm all data values are valid with the controllers and configured
    /// validators
    bool getAreAllFormFieldsValid() {
      final isConfirmEmailInvalid =
          validateWithController(confirmEmailValidator, confirmEmailController);

      final isPolicyNumberInvalid =
          validateWithController(policyNumberValidator, policyNumController);

      final isConfirmPasswordInvalid = validateWithController(
        confirmPasswordValidator,
        confirmPasswordController,
      );

      final isMemberNumberValid =
          validateWithController(memberNumberValidator, memberNumController);

      final isEmailInvalid =
          validateWithController(emailValidator, registerEmailController);

      final isPasswordInvalid = passwordValidator
          .validate(registerPasswordController.text)
          .isNotEmpty;

      return !isConfirmEmailInvalid &&
          !isPolicyNumberInvalid &&
          !isConfirmPasswordInvalid &&
          !isMemberNumberValid &&
          !isEmailInvalid &&
          !isPasswordInvalid &&
          termsChecked;
    }

    /// Update the value listenable to whether the form is valid or not
    void validateForm() {
      widget.isFormValid.value = getAreAllFormFieldsValid();
    }

    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationShouldSubmitState) {
          BlocProvider.of<RegistrationBloc>(context).add(
            RegistrationSubmitEvent(
              request: RegistrationRequest(
                // This is for marketing emails, the client specified they don't want to use this flag anymore so setting to False
                communicationOption: 'False',
                emailAddress: registerEmailController.text.trim(),
                memberNumber: memberNumController.text.trim(),
                password: registerPasswordController.text,
                policyNumber: policyNumController.text.trim(),
              ),
            ),
          );
        } else if (state is RegistrationSuccessState) {
          context.navigator.goToRegisterEmailVerifyPage(
            RegistrationResendRequest.fromRegistrationRequest(
              state.request,
            ),
          );
        } else if (state is RegistrationFailureState) {
          context.showErrorSnackBar(
            text: state.error.message,
          );
        }
      },
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PolicyNumberFormField(
              policyNumController: policyNumController,
              policyNumberValidator: policyNumberValidator,
              onChanged: (_) => validateForm(),
            ),
            MemberNumberFormField(
              memberNumController: memberNumController,
              onChanged: (_) => validateForm(),
              validator: memberNumberValidator,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: kSpacingMedium),
              child: RegisterEmailFormField(
                registerEmailController: registerEmailController,
                labelText: context.getLocalizationOf.emailLabel,
                onChange: (_) => validateForm(),
                validator: emailValidator,
              ),
            ),
            RegisterEmailFormField(
              registerEmailController: confirmEmailController,
              labelText: context.getLocalizationOf.confirmEmailLabel,
              validator: confirmEmailValidator,
              onChange: (_) => validateForm(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: kSpacingXxxl),
              child: Text(
                context.getLocalizationOf.createPassword,
                style: context.tfbText.header3.copyWith(
                  color: TfbBrandColors.blueHighest,
                ),
              ),
            ),
            RegisterPasswordFormField(
              registerPasswordController: registerPasswordController,
              labelText: context.getLocalizationOf.registerPasswordLabel,
              onChanged: (_) => validateForm(),
            ),
            PasswordCriteria(
              passwordController: registerPasswordController,
            ),
            RegisterPasswordFormField(
              registerPasswordController: confirmPasswordController,
              labelText: context.getLocalizationOf.confirmPasswordLabel,
              validator: confirmPasswordValidator.validate,
              onChanged: (_) => validateForm(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kSpacingMedium),
              child: TermsCheckbox(
                termsChecked: termsChecked,
                onChanged: ({value}) => setState(() {
                  termsChecked = value ?? false;
                  validateForm();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validateWithController(
    DataValidator<dynamic> validator,
    TextEditingController controller,
  ) =>
      validator.validate(controller.text)?.isNotEmpty ?? false;

  @override
  void dispose() {
    policyNumController.dispose();
    memberNumController.dispose();
    registerEmailController.dispose();
    confirmEmailController.dispose();
    registerPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
