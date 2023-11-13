import 'package:txfb_insurance_flutter/app/pages/login/widgets/biometrics_state_listener.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/login_email_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/login_forgot_password_cta.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/login_form_submit_button.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/login_password_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/login_register_cta.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/login_remember_me_auth_listener.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/login_remember_me_field.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/login_snackbar_listener.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_email_validator.dart';
import 'package:txfb_insurance_flutter/data/storage/login_remember_me_store.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/device/biometrics/tfb_biometrics.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/domain/models/login/login_request.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> formKey;
  bool rememberMeChecked = false;
  bool isBiometricsEnabled = false;
  bool isFormValid = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    setEmailAndRememberMeInitialState();
    checkBiometrics();
  }

  Future<void> checkBiometrics() async {
    isBiometricsEnabled = await TfbBiometrics().canCheckBiometrics;
  }

  @override
  Widget build(BuildContext context) {
    final tfbEmailValidator = TfbEmailValidator.localizedLogin(context);

    void validateForm() {
      final emailValidationError =
          tfbEmailValidator.validate(emailController.text);
      setState(() {
        isFormValid =
            emailValidationError == null && passwordController.text.isNotEmpty;
      });
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kSpacingMedium,
      ),
      decoration: BoxDecoration(
        color: TfbBrandColors.white,
        borderRadius: context.radii.defaultRadius,
      ),
      child: AutofillGroup(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LoginSnackbarListener(),
              const BiometricsStateListener(),
              LoginRememberMeAuthListener(
                rememberMeChecked: rememberMeChecked,
                emailController: emailController,
              ),
              LoginEmailFormField(
                onChange: (_) => validateForm(),
                emailController: emailController,
                showBiometricIcon: isBiometricsEnabled,
                validator: TfbEmailValidator.localizedLogin(context),
              ),
              LoginPasswordFormField(
                passwordController: passwordController,
                onChange: (_) => validateForm(),
              ),
              const LoginForgotPasswordCTA(),
              LoginFormSubmitButton(
                disabled: !isFormValid,
                formKey: formKey,
                request: LoginRequest(
                  username: emailController.text.trim(),
                  password: passwordController.text,
                ),
              ),
              const LoginRegisterCTA(),
              LoginRememberMeField(
                rememberMeChecked: rememberMeChecked,
                onChanged: ({value}) => setState(() {
                  rememberMeChecked = value ?? false;
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> setEmailAndRememberMeInitialState() async {
    LoginRememberMeStore(
      prefs: await LoginRememberMeStore.getDefaultSharedPrefs(),
    ).get().then((value) {
      if (value != null) {
        emailController.text = value;
      }
      setState(() {
        rememberMeChecked = value != null;
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
