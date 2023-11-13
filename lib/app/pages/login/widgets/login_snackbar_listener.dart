import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class LoginSnackbarListener extends StatelessWidget {
  const LoginSnackbarListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          final error = state.error;
          // TODO: Once PR #67 is merged, update this to use the TextWithPhone widget
          if (error is TfbRequestError) {
            context.showErrorSnackBar(
              text: getErrorMessageFromException(error, context),
            );
          }
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  String getErrorMessageFromException(
    TfbRequestError error,
    BuildContext context,
  ) {
    if (error.message == kLoginError) {
      return context.getLocalizationOf.loginUsernamePasswordNotFoundError;
    }
    return error.message;
  }
}
