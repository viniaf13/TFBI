import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/forgot_password/widgets/forgot_password_button.dart';
import 'package:txfb_insurance_flutter/app/pages/forgot_password/widgets/forgot_password_page_content.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final emailTextEditingController = TextEditingController();
  final shouldDisableNotifier = ValueNotifier(true);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          actions: [
            CancelAppBarAction(
              onPress: context.navigator.goToLoginPage,
            ),
          ],
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),
        body: GradientBackground(
          gradient: LightColors.authenticationBackgroundGradient,
          child: ScrollableViewWithPinnedButton(
            button: ValueListenableBuilder(
              valueListenable: shouldDisableNotifier,
              builder: (context, value, child) {
                return ForgotPasswordButton(
                  disabled: value,
                  onPress: () => onSubmitForm(context),
                );
              },
            ),
            child: ForgotPasswordPageContent(
              shouldDisableNotifier: shouldDisableNotifier,
              formKey: formKey,
              emailTextEditingController: emailTextEditingController,
            ),
          ),
        ),
      ),
    );
  }

  void onSubmitForm(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      BlocProvider.of<ForgotPasswordBloc>(context).add(
        RequestForgotPasswordEvent(
          emailTextEditingController.text,
        ),
      );
    }
  }
}
