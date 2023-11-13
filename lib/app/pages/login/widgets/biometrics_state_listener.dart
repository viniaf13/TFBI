import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/blocs/biometrics/biometrics_bloc.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';
import 'package:txfb_insurance_flutter/shared/tfb_user_repository.dart';

class BiometricsStateListener extends StatelessWidget {
  const BiometricsStateListener({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<BiometricsBloc, BiometricsState>(
      listener: (context, state) {
        if (state is BiometricsSucceeded) {
          context
            ..read<AuthBloc>().add(const AuthSignInEvent())
            ..read<AuthBloc>().add(AuthUpdateUserEvent(state.user));
          TfbUserRepository.instance.shouldSaveUser = true;
        } else if (state is BiometricsFailed) {
          context.handleBioFailure(
            state.error,
            fromTap: state.fromTap,
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
