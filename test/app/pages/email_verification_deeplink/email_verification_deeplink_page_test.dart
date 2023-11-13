import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/cubits/email_verification/email_verification_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/update_login/update_login_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/email_verification_deeplink/email_verification_deeplink_page.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/email_verification/email_verification_response.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/user_information.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_registration_repository.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';

import '../../../device/tfb_secure_storage_test.dart';
import '../../../mocks/bloc/mock_auth_bloc.dart';
import '../../../mocks/mock_member_access_client.dart';
import '../../../mocks/mock_tfb_navigator.dart';
import '../../../mocks/repository/mock_tfb_registration_repository.dart';
import '../../../widgets/tfb_widget_tester.dart';

void main() {
  late TfbMemberRegistrationRepository mockRegistrationRepo;
  late TfbMemberAccessClient mockMemberAccessClient;
  late AuthBloc mockAuthBloc;
  late TfbNavigator mockNavigator;

  setUpAll(() {
    registerFallbackValue(TfbRequestError());
  });

  setUp(() {
    mockRegistrationRepo = MockTfbRegistrationRepository();
    mockMemberAccessClient = MockMemberAccessClient();
    mockAuthBloc = MockAuthBloc();
    mockNavigator = MockTfbNavigator();
  });

  testWidgets(
      'Email verification deeplink page should automatically verify email using the EmailVerificationCubit',
      (tester) async {
    when(() => mockAuthBloc.state).thenReturn(AuthSignedOut());

    await tester.pumpWidget(
      TfbWidgetTester(
        mockAuthBloc: mockAuthBloc,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => EmailVerificationCubit(
                memberRegistrationRepository: mockRegistrationRepo,
              ),
            ),
            BlocProvider(
              create: (context) => UpdateLoginCubit(
                memberAccessClient: mockMemberAccessClient,
                memberNumber: '1234',
              ),
            ),
          ],
          child: const EmailVerificationDeeplinkPage(verificationCode: ''),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 500));

    verify(() => mockRegistrationRepo.verifyEmail(any())).called(1);
  });

  testWidgets(
    'The loading overlay should be present immediately on page load for the email verification deeplink page',
    (tester) async {
      when(() => mockAuthBloc.state).thenReturn(AuthSignedOut());

      await tester.pumpWidget(
        TfbWidgetTester(
          mockAuthBloc: mockAuthBloc,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => EmailVerificationCubit(
                  memberRegistrationRepository: mockRegistrationRepo,
                ),
              ),
              BlocProvider(
                create: (context) => UpdateLoginCubit(
                  memberAccessClient: mockMemberAccessClient,
                  memberNumber: '1234',
                ),
              ),
            ],
            child: const EmailVerificationDeeplinkPage(verificationCode: ''),
          ),
        ),
      );

      expect(find.byType(TfbBrandLoadingIcon), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 500));
    },
  );

  testWidgets(
      'If signed out, after verification succeeds then the app should move the user to the verification success page',
      (tester) async {
    when(() => mockAuthBloc.state).thenReturn(AuthSignedOut());

    when(() => mockRegistrationRepo.verifyEmail(any())).thenAnswer(
      (invocation) => Future.value(
        _validEmailVerificationResponse,
      ),
    );

    await tester.pumpWidget(
      TfbWidgetTester(
        mockAuthBloc: mockAuthBloc,
        mockNavigator: mockNavigator,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => EmailVerificationCubit(
                memberRegistrationRepository: mockRegistrationRepo,
              ),
            ),
            BlocProvider(
              create: (context) => UpdateLoginCubit(
                memberAccessClient: mockMemberAccessClient,
                memberNumber: '1234',
              ),
            ),
          ],
          child: const EmailVerificationDeeplinkPage(verificationCode: ''),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 500));

    verify(() => mockRegistrationRepo.verifyEmail(any())).called(1);
    verify(mockNavigator.goToEmailVerifySuccessPage).called(1);
  });

  testWidgets(
      'If signed in and both the verification and fetch login calls succeed, then the app should move the user to the email update success page',
      (tester) async {
    when(() => mockAuthBloc.state).thenReturn(
      AuthSignedIn(
        testUser,
      ),
    );

    when(() => mockRegistrationRepo.verifyEmail(any())).thenAnswer(
      (invocation) => Future.value(
        _validEmailVerificationResponse,
      ),
    );

    when(() => mockMemberAccessClient.fetchMemberLogin(any())).thenAnswer(
      (invocation) => Future.value(_testUserInformation),
    );

    await tester.pumpWidget(
      TfbWidgetTester(
        mockAuthBloc: mockAuthBloc,
        mockNavigator: mockNavigator,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => EmailVerificationCubit(
                memberRegistrationRepository: mockRegistrationRepo,
              ),
            ),
            BlocProvider(
              create: (context) => UpdateLoginCubit(
                memberAccessClient: mockMemberAccessClient,
                memberNumber: '1234',
              ),
            ),
          ],
          child: const EmailVerificationDeeplinkPage(verificationCode: ''),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 500));

    verify(() => mockRegistrationRepo.verifyEmail(any())).called(1);
    verify(() => mockMemberAccessClient.fetchMemberLogin(any())).called(1);
    verify(mockNavigator.goToUpdateEmailSuccessPage).called(1);
  });

  testWidgets(
      'If the user is signed in, and the email verification step fails, move to the failure screen',
      (tester) async {
    when(() => mockAuthBloc.state).thenReturn(
      AuthSignedIn(
        testUser,
      ),
    );

    when(() => mockRegistrationRepo.verifyEmail(any()))
        .thenThrow(TfbRequestError());

    await tester.pumpWidget(
      TfbWidgetTester(
        mockAuthBloc: mockAuthBloc,
        mockNavigator: mockNavigator,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => EmailVerificationCubit(
                memberRegistrationRepository: mockRegistrationRepo,
              ),
            ),
            BlocProvider(
              create: (context) => UpdateLoginCubit(
                memberAccessClient: mockMemberAccessClient,
                memberNumber: '1234',
              ),
            ),
          ],
          child: const EmailVerificationDeeplinkPage(verificationCode: ''),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 500));

    verify(() => mockRegistrationRepo.verifyEmail(any())).called(1);
    verify(
      () => mockNavigator.goToUpdateEmailFailurePage(
        error: any(named: 'error'),
      ),
    ).called(1);
  });

  testWidgets(
      'If the user is signed in, and the fetch login step fails, move to the failure screen',
      (tester) async {
    when(() => mockAuthBloc.state).thenReturn(
      AuthSignedIn(
        testUser,
      ),
    );

    when(() => mockRegistrationRepo.verifyEmail(any())).thenAnswer(
      (invocation) => Future.value(
        _validEmailVerificationResponse,
      ),
    );

    when(() => mockMemberAccessClient.fetchMemberLogin(any()))
        .thenThrow(TfbRequestError());

    await tester.pumpWidget(
      TfbWidgetTester(
        mockAuthBloc: mockAuthBloc,
        mockNavigator: mockNavigator,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => EmailVerificationCubit(
                memberRegistrationRepository: mockRegistrationRepo,
              ),
            ),
            BlocProvider(
              create: (context) => UpdateLoginCubit(
                memberAccessClient: mockMemberAccessClient,
                memberNumber: '1234',
              ),
            ),
          ],
          child: const EmailVerificationDeeplinkPage(verificationCode: ''),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 500));

    verify(() => mockRegistrationRepo.verifyEmail(any())).called(1);
    verify(
      () => mockNavigator.goToUpdateEmailFailurePage(
        error: any(named: 'error'),
      ),
    ).called(1);
  });
}

final _testUserInformation = [
  UserInformation(
    accountCreateDate: 'accountCreateDate',
    communicationOption: 'communicationOption',
    emailAddress: 'test@test.com',
    emailVerificationIndicator: 'emailVerificationIndicator',
    insuredId: 1234,
    lastLoginDate: 'lastLoginDate',
    memberNumber: 'memberNumber',
    passwordResetIndicator: 'passwordResetIndicator',
    pendingEmailChange: 'pendingEmailChange',
    userName: 'test@test.com',
  ),
];

final _validEmailVerificationResponse = EmailVerificationResponse(
  emailUpdate: '',
  errorMessage: '',
  returnMessage: '',
  verified: '',
);
