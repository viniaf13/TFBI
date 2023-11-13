import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/processing_snackbar_icon.dart';

class ForgotPasswordRequestListenerAlert extends StatelessWidget {
  const ForgotPasswordRequestListenerAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordRequestError) {
          context.showErrorSnackBar(
            text: state.error.message,
          );
        } else if (state is ForgotPasswordRequestSuccess) {
          context.showSuccessSnackBar(
            text: context.getLocalizationOf.emailSentMessage,
            icon: const Icon(
              Icons.check_circle_outline,
            ),
          );
        } else if (state is ForgotPasswordRequestProcessing) {
          context.showProcessingSnackBar(
            text: context.getLocalizationOf.sendingEmailMessage,
            icon: const ProcessingSnackbarIcon(),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
