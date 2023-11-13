import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plugin_haven/haven.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/account_registration_events.dart';
import 'package:txfb_insurance_flutter/app/analytics/tfb_analytics.dart';
import 'package:txfb_insurance_flutter/app/blocs/biometrics/biometrics_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/app_update/app_update_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/email_verification/email_verification_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/forgot_password_verify/forgot_password_verify_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/update_login/update_login_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/email_verification/email_verification_page.dart';
import 'package:txfb_insurance_flutter/app/pages/email_verification_deeplink/email_verification_deeplink_page.dart';
import 'package:txfb_insurance_flutter/app/pages/email_verification_success_failure/email_verification_success_failure_page.dart';
import 'package:txfb_insurance_flutter/app/pages/forgot_password_update/forgot_password_update_page.dart';
import 'package:txfb_insurance_flutter/app/pages/forgot_update_password_success/forgot_update_password_success_page.dart';
import 'package:txfb_insurance_flutter/app/pages/login/login_page.dart';
import 'package:txfb_insurance_flutter/app/pages/pages.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/insurance_card_viewer_page.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_router_query_params.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_routes.dart';
import 'package:txfb_insurance_flutter/app/tfb_app.dart';
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/device/biometrics/tfb_biometrics.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/registration/registration_resend_request.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_auth_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_registration_repository.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

final tfbUnauthenticatedRoutes = [
  GoRoute(
    path: '/',
    pageBuilder: (context, state) {
      // TODO: Figure out why theme extensions aren't loading the first time
      // pageBuilder is called. Also figure out why pageBuilder is being called
      // multiple times to begin with. It should only be called once.

      // *Might* be related to this issue: https://github.com/flutter/flutter/issues/111842
      final theme = Theme.of(context);
      final isThemeConfigured = theme.extensions.isNotEmpty;

      if (!isThemeConfigured) {
        return NoTransitionPage(
          child: Container(
            color: TfbBrandColors.blueHighest,
          ),
        );
      }

      final bool shouldSkipAnimation = bool.tryParse(
            state.uri.queryParameters[
                    TfbRouterQueryParams.loginPageSkipSplashAnimation] ??
                'false',
          ) ??
          false;

      final bool shouldLogout = bool.tryParse(
            state.uri.queryParameters[TfbRouterQueryParams.isLoggingOut] ?? '',
          ) ??
          false;

      final environment = context.getEnvironment<TfbEnvironment>();

      return NoTransitionPage(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => BiometricsBloc(
                biometrics: TfbBiometrics(),
                userStorageRepository: (TfbApp.getEnvConfig(environment)
                        ?.authRepository as TfbAuthRepository)
                    .userStorageRepository,
              ),
            ),
            BlocProvider(create: (context) => AppUpdateCubit()),
          ],
          child: LoginPage(
            shouldSkipSplashAnimation: shouldSkipAnimation,
            shouldLogout: shouldLogout,
          ),
        ),
      );
    },
    routes: [
      GoRoute(
        path: TfbAppRoutes.viewInsuranceCardPdf.relativePath,
        builder: (context, state) => InsuranceCardViewerPage(
          params: state.extra as PdfViewerPageParameters,
        ),
      ),
      GoRoute(
        path: TfbAppRoutes.createAccount.relativePath,
        builder: (context, state) {
          TfbAnalytics.instance.track(
            const AccountRegistrationScreenViewEvent(),
          );

          return CreateAccountPage(
            registrationRepo: context.read<TfbMemberRegistrationRepository>(),
          );
        },
        routes: [
          GoRoute(
            path: TfbAppRoutes.emailVerify.relativePath,
            builder: (context, state) {
              TfbAnalytics.instance.track(
                const RegistrationVerifyEmailScreenViewEvent(),
              );

              final request = RegistrationResendRequest.fromQueryParams(
                state.uri.queryParameters,
              );

              return EmailVerificationPage(
                resendInformation: request,
                memberAccessClient: context.read<TfbMemberAccessClient>(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: TfbAppRoutes.forgotPassword.relativePath,
        builder: (context, state) {
          TfbAnalytics.instance.track(
            const ForgetPasswordScreenViewEvent(),
          );

          return BlocProvider(
            create: (context) => ForgotPasswordBloc(
              memberAccessClient: context.read<TfbMemberAccessClient>(),
            ),
            child: ForgotPasswordPage(),
          );
        },
        routes: [
          GoRoute(
            path: TfbAppRoutes.forgotPasswordVerification.relativePath,
            builder: (context, state) {
              final extra = state.extra;
              final email = extra is String ? extra : null;

              return BlocProvider(
                create: (context) => ForgotPasswordBloc(
                  memberAccessClient: context.read<TfbMemberAccessClient>(),
                  email: email,
                ),
                child: const ForgotPasswordVerifyEmailPage(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: TfbAppRoutes.forgotPasswordUpdate.relativePath,
        builder: (context, state) {
          const String emailKey = 'e';
          const String codeKey = 'i';

          final String? email = state.uri.queryParametersAll[emailKey]?.first;
          final String? code = state.uri.queryParametersAll[codeKey]?.first;

          TfbAnalytics.instance.track(
            const AccountVerifiedScreenViewEvent(),
          );

          return BlocProvider(
            create: (context) => ForgotPasswordVerifyCubit(
              memberAccessClient: context.read<TfbMemberAccessClient>(),
            ),
            child: ForgotPasswordUpdatePage(
              resetEmail: email,
              resetToken: code,
            ),
          );
        },
        routes: [
          GoRoute(
            path: TfbAppRoutes.forgotPasswordUpdateSuccess.relativePath,
            builder: (context, state) {
              TfbAnalytics.instance.track(
                const UpdatePasswordSuccessScreenViewEvent(),
              );

              return const ForgotUpdatePasswordSuccessPage();
            },
          ),
        ],
      ),
      GoRoute(
        path: TfbAppRoutes.emailVerifyDeepLink.relativePath,
        builder: (context, state) {
          final registerRepository =
              context.read<TfbMemberRegistrationRepository>();

          final memberAccessClient = context.tryRead<TfbMemberAccessClient>();
          final memberNumber = context.getUserMemberNumber;
          final isAuthenticated =
              !memberNumber.isNullOrEmpty && memberAccessClient != null;

          const verificationCodeKey = 'i';
          final verificationCode =
              state.uri.queryParameters[verificationCodeKey];

          return MultiBlocProvider(
            providers: [
              BlocProvider<EmailVerificationCubit>(
                create: (context) => EmailVerificationCubit(
                  memberRegistrationRepository: registerRepository,
                ),
              ),
              if (isAuthenticated)
                BlocProvider(
                  create: (context) => UpdateLoginCubit(
                    memberAccessClient: memberAccessClient,
                    memberNumber: memberNumber!,
                  ),
                ),
            ],
            child: EmailVerificationDeeplinkPage(
              verificationCode: verificationCode,
            ),
          );
        },
        routes: [
          GoRoute(
            path: TfbAppRoutes.emailVerifyFailureOrSuccess.relativePath,
            builder: (context, state) {
              final routeExtra = state.extra;

              return EmailVerificationSuccessFailurePage(
                error: routeExtra is TfbRequestError ? routeExtra : null,
              );
            },
          ),
        ],
      ),
    ],
  ),
];
