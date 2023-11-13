import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/processing_snackbar_icon.dart';

class ForgotPasswordBlocListener extends StatelessWidget {
  const ForgotPasswordBlocListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        final bool isOnForgotPasswordPage = context.navigator.location ==
            TfbAppRoutes.forgotPassword.absolutePath;

        if (state is ForgotPasswordRequestSuccess && isOnForgotPasswordPage) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          context.navigator.goToForgotPasswordVerifyPage(state.email);
        } else if (state is ForgotPasswordRequestProcessing &&
            isOnForgotPasswordPage) {
          context.showProcessingSnackBar(
            text: context.getLocalizationOf.requestProcessingLabel,
            icon: const ProcessingSnackbarIcon(),
          );
        } else if (state is ForgotPasswordRequestError &&
            isOnForgotPasswordPage) {
          context.showErrorSnackBar(
            text: state.error.message,
          );
        }
      },
      child: child,
    );
  }
}
