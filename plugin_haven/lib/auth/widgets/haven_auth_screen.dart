import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/auth/auth.dart';

/// Wrapper for the application sign-in screen. Handles auth errors.
class HavenAuthScreen extends StatelessWidget {
  const HavenAuthScreen({super.key, this.onAuthError, required this.child});

  /// Optional custom error handler. Default presents a dialog with the
  /// underlying auth error string.
  final Future Function(BuildContext, AuthError)? onAuthError;

  /// Application specific sign-in screen.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            if (onAuthError != null) {
              onAuthError!(context, state);
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Sign In Error'),
                  content: Text(state.error.toString()),
                ),
              );
            }
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (prev, current) => current is AuthSignedOut,
          builder: (context, state) {
            return child;
          },
        ),
      ),
    );
  }
}
