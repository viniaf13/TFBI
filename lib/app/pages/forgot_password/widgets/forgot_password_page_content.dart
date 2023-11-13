import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/pages/forgot_password/widgets/forgot_password_bloc_listener.dart';
import 'package:txfb_insurance_flutter/app/pages/forgot_password/widgets/forgot_password_form.dart';

class ForgotPasswordPageContent extends StatelessWidget {
  const ForgotPasswordPageContent({
    required this.emailTextEditingController,
    required this.shouldDisableNotifier,
    required this.formKey,
    super.key,
  });

  final TextEditingController emailTextEditingController;
  final GlobalKey<FormState> formKey;
  final ValueNotifier<bool> shouldDisableNotifier;

  @override
  Widget build(BuildContext context) {
    return ForgotPasswordBlocListener(
      child: ListView(
        children: [
          ForgotPasswordForm(
            shouldDisableNotifier: shouldDisableNotifier,
            formKey: formKey,
            emailTextEditingController: emailTextEditingController,
          ),
        ],
      ),
    );
  }
}
