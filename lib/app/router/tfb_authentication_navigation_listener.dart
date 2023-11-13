import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/pages/login/login_page.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_routes.dart';
import 'package:txfb_insurance_flutter/domain/models/login/tfb_user.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

/// Responsible for listening to the [AuthBloc] that is provided by Haven
/// and redirecting the user to the correct screen in the app when the
/// authentication state changes.
class TfbAuthenticationNavigationRedirectListener extends StatelessWidget {
  const TfbAuthenticationNavigationRedirectListener({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    AuthBloc? authBloc;

    try {
      authBloc = BlocProvider.of<AuthBloc>(context);
    } catch (_) {}

    if (authBloc == null) {
      if (kDebugMode) {
        TfbLogger.verbose('No AuthBloc found, returning child.');
      }
      return child;
    }

    return BlocListener<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: navigateUsingAuthState,
      listenWhen: (previous, current) {
        if (current is AuthSignedIn) {
          final properties = current.properties;
          if (properties is Map) {
            final isSignedIn = properties[alreadyLoggedInKey];
            if (isSignedIn is bool && isSignedIn) {
              return false;
            }
          }
        }
        return true;
      },
      child: child,
    );
  }

  void navigateUsingAuthState(BuildContext context, AuthState state) {
    if (state is AuthSignedIn) {
      final user = state.user;
      if (user is! TfbUser) {
        return;
      }

      final emailVerified = user.emailVerified;
      if (emailVerified == null) {
        return;
      }

      if (!emailVerified) {
        TfbLogger.warning(
          'User was authenticated but their email is not verified, so not moving user to dashboard',
          user,
        );
      } else {
        Future<void>.delayed(dashboardOpacityOverlayTransitionDuration, () {
          context.navigator.goToDashboardPage();
        });
      }
    } else if (state is AuthSignedOut) {
      if (context.navigator.location != TfbAppRoutes.login.relativePath) {
        context.navigator.goToLoginPage();
      }
    }
  }
}

Duration getDefaultPageTransitionDuration() => MaterialPageRoute<void>(
      builder: (context) => const SizedBox.shrink(),
    ).transitionDuration;
