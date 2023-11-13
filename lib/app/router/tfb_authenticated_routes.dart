import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/app/cubits/change_password/change_password_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/delete_account/delete_account_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/account/account_page.dart';
import 'package:txfb_insurance_flutter/app/pages/app_info/app_info_page.dart';
import 'package:txfb_insurance_flutter/app/pages/account/change_password.dart';
import 'package:txfb_insurance_flutter/app/pages/account/change_password_success_page.dart';
import 'package:txfb_insurance_flutter/app/pages/account_verify_updated_email/account_verify_updated_email_page.dart';
import 'package:txfb_insurance_flutter/app/pages/authenticated_landing/authenticated_landing_page.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/billing_page.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/claims_landing_page.dart';
import 'package:txfb_insurance_flutter/app/pages/email_update_success_failure/email_update_success_failure_page.dart';
import 'package:txfb_insurance_flutter/app/pages/policies_list/policy_list_page.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_router.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_routes.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_slide_transition_page.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/app/cubits/agent_cubit/agent_cubit.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_agent_lookup_repository.dart';

final tfbAuthenticatedRoutes = [
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: TfbAppRoutes.dashboard.relativePath,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: BlocProvider(
              create: (context) => AgentCubit(
                repository: context.read<TfbAgentLookupRepository>(),
              ),
              child: const AuthenticatedLandingPage(),
            ),
          );
        },
        routes: [
          TfbNamedRoute.policyDetails,
          TfbNamedRoute.fileAClaim,
          TfbNamedRoute.roadsideAssistance,
          TfbNamedRoute.customerService,
          TfbNamedRoute.billingDetails,
          TfbNamedRoute.viewInsuranceCard,
          TfbNamedRoute.autoPayEnrollment,
        ],
      ),
    ],
  ),
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: TfbAppRoutes.policies.relativePath,
        pageBuilder: (context, state) {
          TfbAnalytics.instance.track(const PoliciesScreenViewEvent());
          return const NoTransitionPage(
            child: PolicyListPage(),
          );
        },
        routes: [
          TfbNamedRoute.policyDetails,
        ],
      ),
    ],
  ),
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: TfbAppRoutes.billing.relativePath,
        pageBuilder: (context, state) {
          TfbAnalytics.instance.track(const BillingLandingPageEvent());
          return const NoTransitionPage(
            child: BillingPage(),
          );
        },
        routes: [
          TfbNamedRoute.billingDetails,
          TfbNamedRoute.webViewerPage,
        ],
      ),
    ],
  ),
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: TfbAppRoutes.claims.relativePath,
        pageBuilder: (context, state) {
          TfbAnalytics.instance.track(const ClaimsLandingViewEvent());
          return const NoTransitionPage(
            child: ClaimsLandingPage(),
          );
        },
        routes: [
          TfbNamedRoute.fileAClaim,
        ],
      ),
    ],
  ),
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: TfbAppRoutes.account.relativePath,
        pageBuilder: (context, state) {
          TfbAnalytics.instance.track(const MyAccountScreenViewEvent());

          return NoTransitionPage(
            child: BlocProvider(
              create: (context) => DeleteAccountCubit(
                memberAccessClient: context.read<TfbMemberAccessClient>(),
              ),
              child: const AccountPage(),
            ),
          );
        },
        routes: [
          GoRoute(
            path: TfbAppRoutes.appInfo.relativePath,
            builder: (context, state) {
              return const AppInfoPage();
            },
          ),
          GoRoute(
            path: TfbAppRoutes.accountVerifyUpdateEmail.relativePath,
            parentNavigatorKey: authenticatedNavigatorKey,
            pageBuilder: (context, state) {
              TfbAnalytics.instance.track(const VerifyEmailScreenViewEvent());

              return TfbSlideTransitionPage(
                key: state.pageKey,
                child: const AccountVerifyUpdatedEmailPage(),
              );
            },
            routes: [
              GoRoute(
                path: TfbAppRoutes.accountVerifyUpdateComplete.relativePath,
                parentNavigatorKey: authenticatedNavigatorKey,
                builder: (context, state) {
                  final extra = state.extra;
                  return EmailUpdateSuccessFailurePage(
                    error: extra is TfbRequestError ? extra : null,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: TfbAppRoutes.changePassword.relativePath,
            parentNavigatorKey: authenticatedNavigatorKey,
            pageBuilder: (context, state) {
              TfbAnalytics.instance.track(
                const ChangePasswordScreenViewEvent(),
              );

              return TfbSlideTransitionPage(
                key: state.pageKey,
                child: BlocProvider(
                  create: (context) => ChangePasswordCubit(
                    memberAccessClient: context.read<TfbMemberAccessClient>(),
                  ),
                  child: const ChangePasswordScreen(),
                ),
              );
            },
            routes: [
              GoRoute(
                path: TfbAppRoutes.changePasswordSuccess.relativePath,
                parentNavigatorKey: authenticatedNavigatorKey,
                builder: (context, state) {
                  TfbAnalytics.instance.track(
                    const ChangePasswordSuccessScreenViewEvent(),
                  );
                  return const ChangePasswordSuccessPage();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];
