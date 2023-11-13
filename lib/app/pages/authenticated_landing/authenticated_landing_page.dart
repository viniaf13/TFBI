import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/app/cubits/contacts/contacts_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/dashboard_screen.dart';
import 'package:txfb_insurance_flutter/domain/models/login/tfb_user.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_router.dart';

class AuthenticatedLandingPage extends StatelessWidget {
  const AuthenticatedLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MemberSummaryCubit>(context).getMemberSummary();
    BlocProvider.of<ContactsCubit>(context).request();

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSignedIn) {
          final user = state.user as TfbUser;
          TfbAnalytics.instance.identify(user);
          TfbAnalytics.instance.track(
            SignInEvent(
              usedBiometrics: context.usedBiometrics,
              memberNumber: user.members!.first.memberNumber,
            ),
          );
          return DashboardScreen(
            user: user,
            authenticatedNavigatorKey: authenticatedNavigatorKey,
          );
        } else {
          return Scaffold(
            body: Text(
              'Welcome',
              style: context.tfbText.bodyRegularSmall,
            ),
          );
        }
      },
    );
  }
}
