import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/policy_scroll/policy_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/login/login_page.dart';
import 'package:txfb_insurance_flutter/app/pages/pages.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_agent_lookup_repository.dart';

import '../../domain/repositories/tfb_agent_lookup_repository_test.dart';
import '../../mocks/mock_go_router.dart';
import '../../mocks/mock_policy_scroll_cubit.dart';
import '../../utils/extensions/pump_with_router_extension.dart';
import 'tfb_router_test.dart';

void main() {
  late MockPolicyScrollCubit mockPolicyScrollCubit;
  late MockAgentLookUpClient mockClient;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    registerFallbackValue(FakePolicyScrollState());
  });

  setUp(() {
    mockPolicyScrollCubit = MockPolicyScrollCubit();
    mockClient = MockAgentLookUpClient();

    when(() => mockPolicyScrollCubit.state).thenReturn(const PolicyInitial());
  });
  setUp(TfbRouter.clear);

  testWidgets(
      'Calling the goToDashboardPage method displays the authenticated '
      'landing screen.', (tester) async {
    final GoRouter router = TfbRouter(
      initialLocation: TfbAppRoutes.login.relativePath,
      unauthenticatedProvidersBuilder: TestUnauthenticatedProviders.new,
      authenticatedProvidersBuilder: TestAuthenticatedProviders.new,
    );

    final navigator = TfbNavigator(router: router);

    await tester.pumpWithRouter(
      router,
      builder: (child) => RepositoryProvider(
        create: (context) => TfbAgentLookupRepository(client: mockClient),
        child: BlocProvider<PolicyScrollCubit>.value(
          value: mockPolicyScrollCubit,
          child: Builder(
            builder: (context) {
              navigator.goToDashboardPage();
              return child;
            },
          ),
        ),
      ),
    );

    await tester.pump(const Duration(seconds: 2));

    expect(find.byType(LoginPage), findsNothing);
    expect(find.byType(AuthenticatedLandingPage), findsOneWidget);
  });

  testWidgets(
      'Calling the push to authenticated landing and then back to the '
      'unauthenticated view only shows the unauthenticated view',
      (tester) async {
    final GoRouter router = TfbRouter(
      initialLocation: TfbAppRoutes.login.relativePath,
      unauthenticatedProvidersBuilder: TestUnauthenticatedProviders.new,
      authenticatedProvidersBuilder: TestAuthenticatedProviders.new,
    );
    final navigator = TfbNavigator(router: router);

    await tester.pumpWithRouter(
      router,
      builder: (child) => RepositoryProvider(
        create: (context) => TfbAgentLookupRepository(client: mockClient),
        child: BlocProvider<PolicyScrollCubit>.value(
          value: mockPolicyScrollCubit,
          child: Builder(
            builder: (context) {
              navigator
                ..goToDashboardPage()
                ..goToLoginPage();
              return child;
            },
          ),
        ),
      ),
    );

    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.byType(AuthenticatedLandingPage), findsNothing);
  });

  test(
      'The navigation calls on the navigator should call into the router '
      '"go" method', () {
    final GoRouter mockRouter = MockGoRouter();
    final TfbNavigator navigator = TfbNavigator(router: mockRouter);

    /// Call a method on the navigator, and confirm that method calls the "go"
    /// method on the navigator's router once
    void Function(void Function(TfbNavigator navigator))
        createNavigatorVerifier(
      TfbNavigator navigator,
    ) =>
            (
              void Function(TfbNavigator navigator) call,
            ) {
              call(navigator);
              verify(() => mockRouter.go(any())).called(1);
            };

    final navigatorVerifier = createNavigatorVerifier(navigator);

    /// Confirm this functionality for each of the basic navigation calls
    navigatorVerifier((navigator) => navigator.goToDashboardPage());
    navigatorVerifier((navigator) => navigator.goToLoginPage());
    navigatorVerifier((navigator) => navigator.goToRegistrationPage());
    navigatorVerifier((navigator) => navigator.goToForgotPasswordPage());
    navigatorVerifier(
      (navigator) => navigator.goToForgotPasswordUpdateSuccessPage(),
    );
    navigatorVerifier((navigator) => navigator.goToEmailVerifySuccessPage());
    navigatorVerifier((navigator) => navigator.goToClaimsDetailsPage());
    navigatorVerifier(
      (navigator) => navigator.goToAccountUpdatedEmailVerifyPage(),
    );
    navigatorVerifier((navigator) => navigator.goToChangePasswordSuccessPage());
    navigatorVerifier(
      (navigator) => navigator.goToUpdateEmailSuccessPage(),
    );
    navigatorVerifier(
      (navigator) => navigator.goToPolicyListPage(),
    );
  });
}
