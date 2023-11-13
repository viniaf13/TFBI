import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/cubits/tfb_single_request_cubit/tfb_single_request_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/update_login/update_login_cubit.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/user_information.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

/// A bloc listener to process update login calls, but only if the user is
/// signed in.
///
/// If the user isn't signed in, this just returns the child widget.
class MaybeUpdateEmailListener extends StatelessWidget {
  const MaybeUpdateEmailListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final authState = BlocProvider.of<AuthBloc>(context).state;

    UpdateLoginCubit? updateLoginCubit;
    try {
      updateLoginCubit = BlocProvider.of<UpdateLoginCubit>(context);
    } catch (_) {}

    if (updateLoginCubit == null) {
      return child;
    } else {
      return BlocListener<UpdateLoginCubit, TfbSingleRequestState>(
        listener: (context, state) {
          // TODO: Look into extracting the "authState is AuthSignedIn" logic to
          // something like "context.isSignedIn"
          if (state is TfbSingleRequestSuccess<List<UserInformation>> &&
              authState is AuthSignedIn) {
            _updateUserEmail(state, context);
          } else if (state is TfbSingleRequestFailed) {
            context.navigator.goToUpdateEmailFailurePage(error: state.error);
          }
        },
        child: child,
      );
    }
  }

  void _updateUserEmail(
    TfbSingleRequestSuccess<List<UserInformation>> state,
    BuildContext context,
  ) {
    final updatedEmail = state.response.first.userName;
    final updatedUser = context.user?.copyWith(
      memberEmailAddress: updatedEmail,
      username: updatedEmail,
    );
    if (updatedUser != null) {
      BlocProvider.of<AuthBloc>(context)
        ..add(
          const AuthSignInEvent(
            properties: {
              alreadyLoggedInKey: true,
            },
          ),
        )
        ..add(AuthUpdateUserEvent(updatedUser));
      context.navigator.goToUpdateEmailSuccessPage();
    }
  }
}
