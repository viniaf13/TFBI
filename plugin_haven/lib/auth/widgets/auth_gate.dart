import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/auth/auth.dart';

/// Top level gate in widget tree for authenticated vs unauthenticated
/// flows.
/// [signedIn] widget presented when authenticated.
/// [signedOut] widget presented when unauthenticated.
/// [configureApp] hook for logic to invoke before presenting [signedIn]
/// [processing] optional widget to display during auth processing state.
class AuthGate extends StatelessWidget {
  const AuthGate({
    super.key,
    required this.signedIn,
    required this.signedOut,
    this.configureApp,
    this.processing,
  });

  final Widget signedIn;
  final Widget signedOut;
  final Widget? processing;
  final void Function(HavenUser user)? configureApp;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      buildWhen: (prev, current) => current is! AuthProcessing,
      listener: (context, state) {
        if ((state is AuthSignedIn) && (configureApp != null)) {
          configureApp!(state.user);
        }
      },
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: _stateWidget(state),
        );
      },
    );
  }

  Widget _stateWidget(AuthState state) {
    if (state is AuthSignedIn) {
      return signedIn;
    } else if (state is AuthError) {
      return signedOut;
    } else {
      if ((processing != null) && (state is! AuthSignedOut)) {
        return processing!;
      }
      return signedOut;
    }
  }
}
