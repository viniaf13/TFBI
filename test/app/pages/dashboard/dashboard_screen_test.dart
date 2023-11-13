import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claims_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/contacts/contacts_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/policy_scroll/policy_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/dashboard.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/dashboard_screen.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/policies/policies_section.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_card_header.dart';
import 'package:txfb_insurance_flutter/domain/models/models.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_agent_lookup_repository.dart';

import '../../../domain/repositories/tfb_agent_lookup_repository_test.dart';
import '../../../mocks/bloc/mock_claims_bloc.dart';
import '../../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../../mocks/mock_agent_cubit.dart';
import '../../../mocks/mock_member_summary.dart';
import '../../../mocks/mock_policy_lookup_client.dart';
import '../../../mocks/mock_policy_scroll_cubit.dart';
import '../../../mocks/mock_tfb_user.dart';
import '../../../mocks/repository/mock_tfb_claims_client_repository.dart';
import '../../../widgets/tfb_widget_tester.dart';
import '../../analytics/mock_analytics_provider.dart';
import '../account/account_page_test.dart';

void main() {
  late MockMemberSummaryCubit memberSummaryCubit;
  late MockPolicyScrollCubit mockPolicyScrollCubit;
  late MockAgentLookUpClient mockAgentLookUpClient;
  late MockClaimsBloc mockClaimsBloc;
  late MockClaimsClientRepo mockClaimsClientRepo;
  late MockAnalyticsProvider mockAnalyticsProvider;
  late MockMemberLookupClient mockMemberLookupClient;
  final mockStatusBarScrollCubit = MockStatusBarScrollCubit();

  setUpAll(() {
    mocktail.registerFallbackValue(FakeMemberSummaryState());
    mocktail.registerFallbackValue(FakePolicyScrollState());

    mockAnalyticsProvider = MockAnalyticsProvider();
    TfbAnalytics.instance.add(mockAnalyticsProvider);
    TfbAnalytics.instance.init(const TfbAnalyticsConfig());
  });

  setUp(() {
    memberSummaryCubit = MockMemberSummaryCubit();
    mockPolicyScrollCubit = MockPolicyScrollCubit();
    mockAgentLookUpClient = MockAgentLookUpClient();
    mockClaimsBloc = MockClaimsBloc();
    mockClaimsClientRepo = MockClaimsClientRepo();
    mockMemberLookupClient = MockMemberLookupClient();

    mocktail
        .when(() => memberSummaryCubit.state)
        .thenReturn(MemberSummaryInitial());

    mocktail
        .when(() => mockPolicyScrollCubit.state)
        .thenReturn(const PolicyInitial());

    mocktail.when(() => mockClaimsBloc.state).thenReturn(ClaimsInitState());
    mocktail
        .when(() => mockStatusBarScrollCubit.state)
        .thenReturn(const StatusBarScrollInitial(''));
  });

  testWidgets('Dashboard contains expected sections', (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ClaimsBloc>(
              create: (context) =>
                  ClaimsBloc(claimsRepository: mockClaimsClientRepo),
            ),
            BlocProvider<PolicyScrollCubit>.value(
              value: mockPolicyScrollCubit,
            ),
            BlocProvider<MemberSummaryCubit>.value(
              value: memberSummaryCubit,
            ),
            BlocProvider<ContactsCubit>(
              create: (context) => ContactsCubit(
                client: mockMemberLookupClient,
                memberNumber: '12345',
              ),
            ),
            EmptyAgentCubitProvider(),
          ],
          child: RepositoryProvider(
            create: (context) =>
                TfbAgentLookupRepository(client: mockAgentLookUpClient),
            child: DashboardScreen(
              user: MockTfbUser(),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(DashboardHeader), findsOneWidget);
    expect(find.byType(QuickAccessSection), findsOneWidget);
    expect(find.byType(PoliciesSection), findsOneWidget);
    expect(find.byType(ClaimsSection), findsOneWidget);

    final event = mockAnalyticsProvider.loggedEvents
        .whereType<DashboardScreenViewEvent>()
        .first;

    expect(event.name, kDashboardScreenViewEvent);
  });

  testWidgets('PolicyCard contains expected elements', (tester) async {
    final summary =
        MockPolicy.createPolicySummary(policyType: PolicyType.txPersonalAuto);
    final details = MockPolicy.createAutoPolicyDetail();
    await tester.pumpWidget(
      TfbWidgetTester(
        child: RepositoryProvider(
          create: (context) =>
              TfbAgentLookupRepository(client: mockAgentLookUpClient),
          child: BlocProvider<ClaimsBloc>.value(
            value: mockClaimsBloc,
            child: PolicyCard(summary, details),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(PolicyCardHeader), findsOneWidget);
    expect(find.text('#${summary.policyNumber}'), findsOneWidget);
    expect(find.text('6/2025'), findsOneWidget);
  });
}
