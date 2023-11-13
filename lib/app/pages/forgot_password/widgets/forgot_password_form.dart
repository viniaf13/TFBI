import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/login_email_form_field.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_email_validator.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({
    required this.emailTextEditingController,
    required this.shouldDisableNotifier,
    required this.formKey,
    super.key,
  });

  final TextEditingController emailTextEditingController;
  final GlobalKey<FormState> formKey;
  final ValueNotifier<bool> shouldDisableNotifier;

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  @override
  Widget build(BuildContext context) {
    final validator = TfbEmailValidator.localizedForgotPassword(context);

    void validateForm() {
      widget.shouldDisableNotifier.value = validator
              .validate(widget.emailTextEditingController.text)
              ?.isNotEmpty ??
          false;
    }

    return Form(
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpacingExtraLarge),
        child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
          builder: (context, state) {
            final bool shouldDisableForm =
                state is ForgotPasswordRequestProcessing;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.getLocalizationOf.loginForgotPassword,
                  style: context.tfbText.header3.copyWith(
                    color: TfbBrandColors.blueHighest,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: kSpacingMedium,
                    bottom: kSpacingExtraLarge,
                  ),
                  child: Text(
                    context.getLocalizationOf.forgotPasswordEmailPageSubtitle,
                    style: context.tfbText.bodyRegularLarge,
                  ),
                ),
                LoginEmailFormField(
                  validator: validator,
                  disabled: shouldDisableForm,
                  showBiometricIcon: false,
                  emailController: widget.emailTextEditingController,
                  onChange: (value) => validateForm(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
