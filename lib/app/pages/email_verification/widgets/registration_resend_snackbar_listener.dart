import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/registration_resend/registration_resend_cubit.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/processing_snackbar_icon.dart';

class RegistrationResendSnackbarListener extends StatelessWidget {
  const RegistrationResendSnackbarListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationResendCubit, RegistrationResendState>(
      listener: (context, state) {
        if (state is RegistrationResendError) {
          context.showErrorSnackBar(
            text: state.error.message,
          );
        } else if (state is RegistrationResendSuccess) {
          context.showSuccessSnackBar(
            text: context.getLocalizationOf.emailSentMessage,
            icon: const Icon(
              Icons.check_circle_outline,
            ),
          );
        } else if (state is RegistrationResendProcessing) {
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
