import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/auth/auth_bloc.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/blocs/biometrics/biometrics_bloc.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/domain/models/login/login_request.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/extensions/focus_extension.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/biometrics_settings_dialog.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/enable_biometrics_dialog.dart';

class LoginFormSubmitButton extends StatefulWidget {
  const LoginFormSubmitButton({
    required this.formKey,
    required this.disabled,
    required this.request,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final LoginRequest request;
  final bool? disabled;

  @override
  State<LoginFormSubmitButton> createState() => _LoginFormSubmitButtonState();
}

class _LoginFormSubmitButtonState extends State<LoginFormSubmitButton> {
  bool showGoToSettingsDialog = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BiometricsBloc, BiometricsState>(
      listener: (context, state) {
        if (state is BiometricsReadyState) {
          showGoToSettingsDialog =
              (Platform.isIOS && state.isEnabled == false) ? true : false;
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          bottom: kSpacingMedium,
          top: kSpacingMedium,
        ),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            void onPressSubmit() {
              if (!widget.formKey.currentState!.validate() ||
                  state is AuthProcessing) {
                return;
              }

              context.dismissCurrentFocus();

              showDialog<void>(
                context: context,
                builder: (_) => Provider.value(
                  value: context.navigator,
                  child: showGoToSettingsDialog
                      ? BiometricsSettingsDialog(loginRequest: widget.request)
                      : EnableBiometricsDialog(
                          loginRequest: widget.request,
                          parentContext: context,
                        ),
                ),
              );
            }

            return TfbFilledButton.primaryTextButton(
              onPressed: (widget.disabled ?? false) ? null : onPressSubmit,
              title: context.getLocalizationOf.loginSignInCTA,
            );
          },
        ),
      ),
    );
  }
}
