import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/blocs/biometrics/biometrics_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/registration/registration_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/app_update/app_update_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/tfb_single_request_cubit/tfb_single_request_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/create_account/widgets/register_account_widgets.dart';
import 'package:txfb_insurance_flutter/app/pages/login/login_page.dart';
import 'package:txfb_insurance_flutter/app/pages/pages.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/device/device.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/secure_registration_request.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_registration_repository.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

import '../../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../../mocks/mock_biometrics.dart';
import '../../../mocks/mock_member_access_client.dart';
import '../../../mocks/mock_registration_repository.dart';
import '../../../mocks/mock_tfb_authentication_repository.dart';
import '../../../mocks/mock_tfb_navigator.dart';
import '../../../mocks/mock_tfb_user_storage_repository.dart';
import '../../../widgets/empty_mock_tfb_auto_policy_document_metadata_repository_provider.dart';
import '../../../widgets/tfb_widget_tester.dart';

class MockAppUpdateCubit extends MockCubit<TfbSingleRequestState>
    implements AppUpdateCubit {}

void main() {
  final TfbNavigator mockNavigator = MockTfbNavigator();
  final AuthRepository<dynamic> mockAuthRepository =
      MockTfbAuthenticationRepository();
  final AuthBloc mockAuthBloc = AuthBloc(authenticator: mockAuthRepository);
  final mockMemberAccessClient = MockMemberAccessClient();
  final TfbMemberRegistrationRepository mockRegistrationRepo =
      TfbMemberRegistrationRepository(networkClient: mockMemberAccessClient);
  final RegistrationBloc registrationBloc =
      RegistrationBloc(repository: mockRegistrationRepo);
  final mockStatusBarScrollCubit = MockStatusBarScrollCubit();

  setUpAll(() {
    registerFallbackValue(
      RegistrationRequest(
        communicationOption: 'communicationOption',
        emailAddress: 'emailAddress',
        memberNumber: 'memberNumber',
        password: 'password',
        policyNumber: 'policyNumber',
      ),
    );
    when(() => mockStatusBarScrollCubit.state)
        .thenReturn(const StatusBarScrollInitial(''));
  });

  testWidgets(
      'Tapping on the create account CTA on the login page will call the navigator pushCreateAccountPage method',
      (tester) async {
    final biometrics = MockBiometrics();

    when(mockNavigator.goToRegistrationPage)
        .thenAnswer((invocation) => Future<void>.value());
    when(biometrics.isBiometricsEnabled).thenAnswer((_) async => true);

    final userStorageRepository = MockTfbUserStorageRepository();

    when(userStorageRepository.getUser)
        .thenAnswer((invocation) => Future.value());

    await tester.pumpWidget(
      BlocProvider(
        create: (context) => mockAuthBloc,
        child: EmptyMockTfbAutoPolicyDocumentMetadataRepositoryProvider(
          child: TfbWidgetTester(
            mockStatusBarScrollCubit: mockStatusBarScrollCubit,
            mockNavigator: mockNavigator,
            mockAuthBloc: mockAuthBloc,
            child: BlocProvider(
              create: (context) => BiometricsBloc(
                biometrics: biometrics,
                userStorageRepository: userStorageRepository,
              ),
              child: const LoginPage(),
            ),
          ),
        ),
      ),
    );

    // Wait for the splash animation to complete
    await tester.pumpAndSettle(const Duration(seconds: 3));

    await tester.tap(
      find.byWidgetPredicate(
        (widget) => widget is GestureDetector && widget.child is RichText,
      ),
    );

    verify(mockNavigator.goToRegistrationPage).called(1);
  });

  testWidgets('Find each form field widget on the create account page.',
      (tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => registrationBloc),
          BlocProvider(create: (context) => mockAuthBloc),
        ],
        child: Provider(
          create: (context) => mockNavigator,
          child: TfbWidgetTester(
            mockStatusBarScrollCubit: mockStatusBarScrollCubit,
            mockEnvironment: TfbEnvironmentStage(),
            child: CreateAccountPage(registrationRepo: mockRegistrationRepo),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    final Finder policyNumber = find.widgetWithText(
      TextFormField,
      AppLocalizationsEn().policyNumLabel,
      skipOffstage: false,
    );
    final Finder memberNumber = find.widgetWithText(
      TextFormField,
      AppLocalizationsEn().memberNumLabel,
      skipOffstage: false,
    );
    final Finder emailFormField = find.widgetWithText(
      TextFormField,
      AppLocalizationsEn().registerEmailLabel,
      skipOffstage: false,
    );
    final Finder confirmEmailFormField = find.widgetWithText(
      TextFormField,
      AppLocalizationsEn().confirmEmailLabel,
      skipOffstage: false,
    );
    final Finder passwordFormField = find.widgetWithText(
      TextFormField,
      AppLocalizationsEn().registerPasswordLabel,
      skipOffstage: false,
    );
    final Finder confirmPasswordFormField = find.widgetWithText(
      TextFormField,
      AppLocalizationsEn().confirmPasswordLabel,
      skipOffstage: false,
    );

    expect(policyNumber, findsOneWidget);
    expect(memberNumber, findsOneWidget);
    expect(emailFormField, findsOneWidget);
    expect(confirmEmailFormField, findsOneWidget);
    expect(passwordFormField, findsOneWidget);
    expect(confirmPasswordFormField, findsOneWidget);
  });

  testWidgets(
      'Tapping on the complete registration button without filling out any form fields should do nothing',
      (tester) async {
    final TfbMemberRegistrationRepository mockRegistrationRepository =
        MockRegistrationRepository();

    await tester.pumpWidget(
      BlocProvider(
        create: (context) => mockAuthBloc,
        child: Provider(
          create: (context) => mockNavigator,
          child: TfbWidgetTester(
            mockStatusBarScrollCubit: mockStatusBarScrollCubit,
            mockEnvironment: TfbEnvironmentStage(),
            child: CreateAccountPage(registrationRepo: mockRegistrationRepo),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(TfbFilledButton));
    await tester.pumpAndSettle();

    verifyNever(() => mockRegistrationRepository.registerUser(any()));

    expect(
      find.byWidgetPredicate(
        (widget) => widget is RegisterAccountButton && widget.disabled == true,
      ),
      findsOneWidget,
    );
  });
}
