import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claims_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/contacts/contacts_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/policy_scroll/policy_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/tfb_single_request_cubit/tfb_single_request_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/login/login_page.dart';
import 'package:txfb_insurance_flutter/app/pages/pages.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/claims_list/claims_list.dart';
import 'package:txfb_insurance_flutter/domain/models/member_lookup/contact.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/member_summary.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_agent_lookup_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';

import '../../device/tfb_secure_storage_test.dart';
import '../../domain/repositories/tfb_agent_lookup_repository_test.dart';
import '../../mocks/bloc/mock_auth_bloc.dart';
import '../../mocks/bloc/mock_claims_bloc.dart';
import '../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../mocks/mock_policy_scroll_cubit.dart';
import '../../mocks/mock_tfb_navigator.dart';
import '../../mocks/mock_tfb_policy_lookup_repository.dart';
import '../../mocks/repository/mock_tfb_claims_client_repository.dart';
import '../../utils/extensions/pump_with_router_extension.dart';
import '../../widgets/empty_mock_tfb_auto_policy_document_metadata_repository_provider.dart';
import '../../widgets/tfb_widget_tester.dart';

class MockContactsCubit extends MockCubit<TfbSingleRequestState>
    implements ContactsCubit {}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(TfbRouter.clear);

  testWidgets(
      'Providing no initial path to the router should display the login screen',
      (tester) async {
    await tester.pumpWithRouter(
      TfbRouter(
        unauthenticatedProvidersBuilder: TestUnauthenticatedProviders.new,
        authenticatedProvidersBuilder: TestAuthenticatedProviders.new,
      ),
    );

    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.byType(AuthenticatedLandingPage), findsNothing);
  });

  testWidgets('The authenticated route should show the authenticated page',
      (tester) async {
    await tester.pumpWithRouter(
      TfbRouter(
        initialLocation: TfbAppRoutes.dashboard.absolutePath,
        authenticatedProvidersBuilder: TestAuthenticatedProviders.new,
        unauthenticatedProvidersBuilder: TestUnauthenticatedProviders.new,
      ),
    );

    await tester.pump(const Duration(seconds: 2));

    expect(find.byType(AuthenticatedLandingPage), findsOneWidget);
    expect(find.byType(LoginPage), findsNothing);
  });
}

class TestUnauthenticatedProviders extends StatelessWidget {
  const TestUnauthenticatedProviders(this.child, {super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final AuthBloc mockAuthBloc = MockAuthBloc();
    when(() => mockAuthBloc.state).thenReturn(AuthSignedOut());

    final mockTfbNavigator = MockTfbNavigator();
    when(() => mockTfbNavigator.location)
        .thenReturn(TfbAppRoutes.login.absolutePath);

    return EmptyMockTfbAutoPolicyDocumentMetadataRepositoryProvider(
      child: TfbWidgetTester(
        mockNavigator: mockTfbNavigator,
        mockAuthBloc: mockAuthBloc,
        child: child,
      ),
    );
  }
}

class TestAuthenticatedProviders extends StatelessWidget {
  const TestAuthenticatedProviders(this.child, {super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final AuthBloc mockAuthBloc = MockAuthBloc();
    when(() => mockAuthBloc.state).thenReturn(AuthSignedIn(testUser));

    final MockPolicyScrollCubit mockPolicyScrollCubit = MockPolicyScrollCubit();
    when(() => mockPolicyScrollCubit.state).thenReturn(const PolicyInitial());

    final TfbPolicyLookupRepository mockPolicyLookupRepository =
        MockTfbPolicyLookupRepository();
    when(mockPolicyLookupRepository.getMemberSummary)
        .thenAnswer((invocation) => Future.value(MemberSummary(policies: [])));

    final mockTfbNavigator = MockTfbNavigator();
    when(() => mockTfbNavigator.location)
        .thenReturn(TfbAppRoutes.dashboard.absolutePath);

    final MockAgentLookUpClient mockClient = MockAgentLookUpClient();

    final MockClaimsClientRepo mockClaimsClientRepository =
        MockClaimsClientRepo();

    when(() => mockClaimsClientRepository.getAllMemberClaims('memberNumber'))
        .thenAnswer((_) => Future.value(ClaimsList(claims: [])));

    final MockClaimsBloc mockClaimsBloc = MockClaimsBloc();
    when(() => mockClaimsBloc.state).thenReturn(ClaimsInitState());

    final ContactsCubit mockContactsCubit = MockContactsCubit();
    when(() => mockContactsCubit.state)
        .thenReturn(const TfbSingleRequestSuccess(response: <Contact>[]));
    when(mockContactsCubit.request).thenAnswer((invocation) async => []);

    final mockStatusBarScrollCubit = MockStatusBarScrollCubit();
    when(() => mockStatusBarScrollCubit.state)
        .thenReturn(const StatusBarScrollInitial(''));

    return TfbWidgetTester(
      mockStatusBarScrollCubit: mockStatusBarScrollCubit,
      mockNavigator: mockTfbNavigator,
      mockAuthBloc: mockAuthBloc,
      mockPolicyScrollCubit: mockPolicyScrollCubit,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ClaimsBloc>(
            create: (context) =>
                ClaimsBloc(claimsRepository: mockClaimsClientRepository),
          ),
          BlocProvider.value(value: mockContactsCubit),
        ],
        child: RepositoryProvider(
          create: (context) => TfbAgentLookupRepository(client: mockClient),
          child: BlocProvider<MemberSummaryCubit>(
            create: (context) =>
                MemberSummaryCubit(repository: mockPolicyLookupRepository),
            child: BlocProvider<PolicyScrollCubit>.value(
              value: mockPolicyScrollCubit,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
