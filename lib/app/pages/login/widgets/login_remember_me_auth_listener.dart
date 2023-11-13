import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/auth/auth_bloc.dart';
import 'package:txfb_insurance_flutter/data/storage/login_remember_me_store.dart';

/// Responsible for listening to the AuthBloc and storing the email value
/// based on whether the "remember me" checkbox is checked
class LoginRememberMeAuthListener extends StatelessWidget {
  const LoginRememberMeAuthListener({
    required this.rememberMeChecked,
    required this.emailController,
    super.key,
  });

  final bool rememberMeChecked;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthSignedIn) {
          final preferencesStore =
              await LoginRememberMeStore.getDefaultSharedPrefs();
          if (rememberMeChecked) {
            LoginRememberMeStore(prefs: preferencesStore)
                .store(email: emailController.text);
          } else {
            LoginRememberMeStore(prefs: preferencesStore).clear();
          }
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
