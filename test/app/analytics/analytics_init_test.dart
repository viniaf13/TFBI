import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:plugin_haven/auth/auth_bloc.dart';
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claims_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/contacts/contacts_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/policy_scroll/policy_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/authenticated_landing/authenticated_landing_page.dart';
import 'package:txfb_insurance_flutter/domain/clients/member_lookup_client.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_agent_lookup_repository.dart';

import '../../domain/repositories/tfb_agent_lookup_repository_test.dart';
import '../../mocks/bloc/mock_auth_bloc.dart';
import '../../mocks/bloc/mock_claims_bloc.dart';
import '../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../mocks/mock_agent_cubit.dart';
import '../../mocks/mock_member_summary.dart';
import '../../mocks/mock_policy_scroll_cubit.dart';
import '../../mocks/mock_tfb_user.dart';
import '../../mocks/repository/mock_tfb_claims_client_repository.dart';
import '../../widgets/tfb_widget_tester.dart';
import 'mock_analytics_provider.dart';

class MockTfbMemberLookupClient extends mocktail.Mock
    implements TfbMemberLookupClient {}

void main() {
  late MockAnalyticsProvider analytics;
  late MockMemberSummaryCubit memberSummaryCubit;
  late MockPolicyScrollCubit mockPolicyScrollCubit;
  late MockAgentLookUpClient mockAgentLookUpClient;
  late MockClaimsBloc mockClaimsBloc;
  late MockClaimsClientRepo mockClaimsClientRepo;
  late MockAuthBloc mockAuthBloc;
  late MockStatusBarScrollCubit mockStatusBarScrollCubit;

  setUpAll(() async {
    mocktail.registerFallbackValue(FakeMemberSummaryState());
    mocktail.registerFallbackValue(FakePolicyScrollState());

    memberSummaryCubit = MockMemberSummaryCubit();
    mockPolicyScrollCubit = MockPolicyScrollCubit();
    mockAgentLookUpClient = MockAgentLookUpClient();
    mockClaimsBloc = MockClaimsBloc();
    mockClaimsClientRepo = MockClaimsClientRepo();
    mockAuthBloc = MockAuthBloc();
    mockStatusBarScrollCubit = MockStatusBarScrollCubit();

    mocktail
        .when(() => mockAuthBloc.state)
        .thenReturn(AuthSignedIn(MockTfbUser()));

    mocktail
        .when(() => memberSummaryCubit.state)
        .thenReturn(MemberSummaryInitial());

    mocktail
        .when(() => mockPolicyScrollCubit.state)
        .thenReturn(const PolicyInitial());

    mocktail
        .when(() => mockStatusBarScrollCubit.state)
        .thenReturn(const StatusBarScrollInitial(''));

    mocktail.when(() => mockClaimsBloc.state).thenReturn(ClaimsInitState());

    analytics = MockAnalyticsProvider();
    TfbAnalytics.instance.add(analytics);
  });
  testWidgets(
    'Authenticated landing page starts analytics session',
    (tester) async {
      TfbAnalytics.instance.init(const TfbAnalyticsConfig());
      expect(analytics.loggedEvents.contains(const AppFirstOpen()), true);
      await tester.pumpWidget(
        TfbWidgetTester(
          mockStatusBarScrollCubit: mockStatusBarScrollCubit,
          mockAuthBloc: mockAuthBloc,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<ClaimsBloc>(
                create: (context) =>
                    ClaimsBloc(claimsRepository: mockClaimsClientRepo),
              ),
              BlocProvider<ContactsCubit>.value(
                value: ContactsCubit(
                  client: MockTfbMemberLookupClient(),
                  memberNumber: 'memberNumber',
                ),
              ),
              BlocProvider<PolicyScrollCubit>.value(
                value: mockPolicyScrollCubit,
              ),
              BlocProvider<MemberSummaryCubit>.value(
                value: memberSummaryCubit,
              ),
              EmptyAgentCubitProvider(),
            ],
            child: RepositoryProvider(
              create: (context) =>
                  TfbAgentLookupRepository(client: mockAgentLookUpClient),
              child: const AuthenticatedLandingPage(),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(analytics.properties, isA<TfbAnalyticsUserProperties>());
    },
  );
}
