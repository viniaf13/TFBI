import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:txfb_insurance_flutter/app/blocs/claims/claims_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/contacts/contacts_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/policy_scroll/policy_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/dashboard_screen.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/policies/policies_section.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/policies/policy_section_counter.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/member_summary.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_agent_lookup_repository.dart';
import 'package:txfb_insurance_flutter/shared/widgets/decorated_container_with_loading.dart';
import 'package:txfb_insurance_flutter/shared/widgets/decorated_failure_container.dart';

import '../../../../domain/repositories/tfb_agent_lookup_repository_test.dart';
import '../../../../mocks/bloc/mock_claims_bloc.dart';
import '../../../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../../../mocks/mock_agent_cubit.dart';
import '../../../../mocks/mock_member_summary.dart';
import '../../../../mocks/mock_policy_lookup_client.dart';
import '../../../../mocks/mock_policy_scroll_cubit.dart';
import '../../../../mocks/mock_tfb_user.dart';
import '../../../../mocks/repository/mock_tfb_claims_client_repository.dart';
import '../../../../widgets/tfb_widget_tester.dart';
import '../../account/account_page_test.dart';

void main() {
  late MockMemberSummaryCubit memberSummaryCubit;
  late MockPolicyScrollCubit mockPolicyScrollCubit;
  late MockAgentLookUpClient mockAgentLookUpClient;
  late MockClaimsBloc mockClaimsBloc;
  late MockClaimsClientRepo mockClaimsClientRepo;
  late MockMemberLookupClient mockMemberLookupClient;
  final mockStatusBarScrollCubit = MockStatusBarScrollCubit();

  setUpAll(() {
    mocktail.registerFallbackValue(FakeMemberSummaryState());
    mocktail.registerFallbackValue(FakePolicyScrollState());
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

  testWidgets('Counter Policy Section contains expected element Counter',
      (tester) async {
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
    await tester.pump();

    expect(find.byType(PolicySectionCounter), findsOneWidget);
  });

  testWidgets(
      'Counter Policy Section contains expected initial element counter',
      (tester) async {
    mocktail.when(() => memberSummaryCubit.state).thenReturn(
          MemberSummarySuccess(
            memberSummary: MemberSummary(
              policies: [
                MockPolicy.createPolicySummary(),
                MockPolicy.createPolicySummary(
                  policyType: PolicyType.txPersonalAuto,
                ),
                MockPolicy.createPolicySummary(
                  policyType: PolicyType.agAdvantage,
                ),
                MockPolicy.createPolicySummary(
                  policyType: PolicyType.inlandMarine,
                ),
              ],
            ),
          ),
        );

    mocktail.when(() => mockPolicyScrollCubit.state).thenReturn(
          const PolicyScrolled(
            isScrolled: true,
            policiesLength: 4,
            policyVisible: 1,
          ),
        );

    await tester.pumpWidget(
      TfbWidgetTester(
        child: RepositoryProvider(
          create: (context) =>
              TfbAgentLookupRepository(client: mockAgentLookUpClient),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<MemberSummaryCubit>.value(
                value: memberSummaryCubit,
              ),
              BlocProvider<ClaimsBloc>(
                create: (context) =>
                    ClaimsBloc(claimsRepository: mockClaimsClientRepo),
              ),
              BlocProvider<PolicyScrollCubit>.value(
                value: mockPolicyScrollCubit,
              ),
            ],
            child: PoliciesSection(
              sectionTitle: AppLocalizationsEn().policiesSectionTitle,
            ),
          ),
        ),
      ),
    );

    await tester.pump();
    expect(find.byType(PolicySectionCounter), findsOneWidget);
    expect(find.textContaining('1/4'), findsOneWidget);
  });

  testWidgets('Counter Policy Section contains expected change element counter',
      (tester) async {
    mocktail.when(() => memberSummaryCubit.state).thenReturn(
          MemberSummarySuccess(
            memberSummary: MemberSummary(
              policies: [
                MockPolicy.createPolicySummary(),
                MockPolicy.createPolicySummary(
                  policyType: PolicyType.txPersonalAuto,
                ),
                MockPolicy.createPolicySummary(
                  policyType: PolicyType.agAdvantage,
                ),
                MockPolicy.createPolicySummary(
                  policyType: PolicyType.inlandMarine,
                ),
              ],
            ),
          ),
        );

    mocktail.when(() => mockPolicyScrollCubit.state).thenReturn(
          const PolicyScrolled(
            isScrolled: true,
            policiesLength: 4,
            policyVisible: 2,
          ),
        );

    await tester.pumpWidget(
      TfbWidgetTester(
        child: RepositoryProvider(
          create: (context) =>
              TfbAgentLookupRepository(client: mockAgentLookUpClient),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<MemberSummaryCubit>.value(
                value: memberSummaryCubit,
              ),
              BlocProvider<ClaimsBloc>(
                create: (context) =>
                    ClaimsBloc(claimsRepository: mockClaimsClientRepo),
              ),
              BlocProvider<PolicyScrollCubit>.value(
                value: mockPolicyScrollCubit,
              ),
            ],
            child: PoliciesSection(
              sectionTitle: AppLocalizationsEn().policiesSectionTitle,
            ),
          ),
        ),
      ),
    );

    await tester.pump();

    expect(find.textContaining('2/4'), findsOneWidget);
  });

  testWidgets('Counter Policy Section contains expected change element counter',
      (tester) async {
    mocktail.when(() => memberSummaryCubit.state).thenReturn(
          const MemberSummaryProcessing(isPullToRefresh: false),
        );

    mocktail.when(() => mockPolicyScrollCubit.state).thenReturn(
          const PolicyScrolled(
            isScrolled: true,
            policiesLength: 0,
            policyVisible: 0,
          ),
        );

    await tester.pumpWidget(
      TfbWidgetTester(
        child: RepositoryProvider(
          create: (context) =>
              TfbAgentLookupRepository(client: mockAgentLookUpClient),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<MemberSummaryCubit>.value(
                value: memberSummaryCubit,
              ),
              BlocProvider<ClaimsBloc>(
                create: (context) =>
                    ClaimsBloc(claimsRepository: mockClaimsClientRepo),
              ),
              BlocProvider<PolicyScrollCubit>.value(
                value: mockPolicyScrollCubit,
              ),
            ],
            child: PoliciesSection(
              sectionTitle: AppLocalizationsEn().policiesSectionTitle,
            ),
          ),
        ),
      ),
    );

    await tester.pump();

    expect(find.textContaining('0/0'), findsNothing);
  });

  testWidgets(
    'Loading container should display on loading',
    (tester) async {
      mocktail.when(() => memberSummaryCubit.state).thenReturn(
            const MemberSummaryProcessing(isPullToRefresh: false),
          );

      mocktail.when(() => mockPolicyScrollCubit.state).thenReturn(
            const PolicyScrolled(
              isScrolled: true,
              policiesLength: 0,
              policyVisible: 0,
            ),
          );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: RepositoryProvider(
            create: (context) =>
                TfbAgentLookupRepository(client: mockAgentLookUpClient),
            child: MultiBlocProvider(
              providers: [
                BlocProvider<MemberSummaryCubit>.value(
                  value: memberSummaryCubit,
                ),
                BlocProvider<ClaimsBloc>(
                  create: (context) =>
                      ClaimsBloc(claimsRepository: mockClaimsClientRepo),
                ),
                BlocProvider<PolicyScrollCubit>.value(
                  value: mockPolicyScrollCubit,
                ),
              ],
              child: PoliciesSection(
                sectionTitle: AppLocalizationsEn().policiesSectionTitle,
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(DecoratedContainerWithLoading), findsOneWidget);
    },
  );

  testWidgets(
    'Loading container should NOT display after loading',
    (tester) async {
      mocktail.when(() => memberSummaryCubit.state).thenReturn(
            MemberSummaryDetailsSuccess(
              memberSummary: MemberSummary(
                policies: [
                  MockPolicy.createPolicySummary(),
                  MockPolicy.createPolicySummary(
                    policyType: PolicyType.txPersonalAuto,
                  ),
                  MockPolicy.createPolicySummary(
                    policyType: PolicyType.agAdvantage,
                  ),
                  MockPolicy.createPolicySummary(
                    policyType: PolicyType.inlandMarine,
                  ),
                ],
              ),
              policyMap: {'00000': MockPolicy.createHomeownerPolicyDetail()},
            ),
          );

      mocktail.when(() => mockPolicyScrollCubit.state).thenReturn(
            const PolicyScrolled(
              isScrolled: true,
              policiesLength: 4,
              policyVisible: 2,
            ),
          );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: RepositoryProvider(
            create: (context) =>
                TfbAgentLookupRepository(client: mockAgentLookUpClient),
            child: MultiBlocProvider(
              providers: [
                BlocProvider<MemberSummaryCubit>.value(
                  value: memberSummaryCubit,
                ),
                BlocProvider<ClaimsBloc>.value(
                  value: mockClaimsBloc,
                ),
              ],
              child: BlocProvider<PolicyScrollCubit>.value(
                value: mockPolicyScrollCubit,
                child: PoliciesSection(
                  sectionTitle: AppLocalizationsEn().policiesSectionTitle,
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(DecoratedContainerWithLoading), findsNothing);
    },
  );

  testWidgets(
    'Policies section displays error message on api failure',
    (tester) async {
      mocktail.when(() => memberSummaryCubit.state).thenReturn(
            MemberSummaryFailure(error: TfbRequestError()),
          );

      mocktail.when(() => mockPolicyScrollCubit.state).thenReturn(
            const PolicyScrolled(
              isScrolled: true,
              policiesLength: 4,
              policyVisible: 2,
            ),
          );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: RepositoryProvider(
            create: (context) =>
                TfbAgentLookupRepository(client: mockAgentLookUpClient),
            child: MultiBlocProvider(
              providers: [
                BlocProvider<MemberSummaryCubit>.value(
                  value: memberSummaryCubit,
                ),
                BlocProvider<ClaimsBloc>(
                  create: (context) =>
                      ClaimsBloc(claimsRepository: mockClaimsClientRepo),
                ),
                BlocProvider<PolicyScrollCubit>.value(
                  value: mockPolicyScrollCubit,
                ),
              ],
              child: PoliciesSection(
                sectionTitle: AppLocalizationsEn().policiesSectionTitle,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(DecoratedFailureContainer), findsOneWidget);
    },
  );
  testWidgets('Policy Section when user have no supported policies to display',
      (tester) async {
    mocktail.when(() => memberSummaryCubit.state).thenReturn(
          MemberSummaryDetailsSuccess(
            memberSummary: MemberSummary(
              policies: [
                MockPolicy.createPolicySummary(
                  policyType: PolicyType.unsupportedPolicy,
                ),
              ],
            ),
            policyMap: {'00000': MockPolicy.createHomeownerPolicyDetail()},
          ),
        );

    mocktail.when(() => mockPolicyScrollCubit.state).thenReturn(
          const PolicyScrolled(
            isScrolled: true,
            policiesLength: 4,
            policyVisible: 2,
          ),
        );

    await tester.pumpWidget(
      TfbWidgetTester(
        child: RepositoryProvider(
          create: (context) =>
              TfbAgentLookupRepository(client: mockAgentLookUpClient),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<MemberSummaryCubit>.value(
                value: memberSummaryCubit,
              ),
              BlocProvider<ClaimsBloc>(
                create: (context) =>
                    ClaimsBloc(claimsRepository: mockClaimsClientRepo),
              ),
              BlocProvider<PolicyScrollCubit>.value(
                value: mockPolicyScrollCubit,
              ),
            ],
            child: PoliciesSection(
              sectionTitle: AppLocalizationsEn().policiesSectionTitle,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(
      find.text(AppLocalizationsEn().youHaveNoAppSupportedPoliciesToDisplay),
      findsOneWidget,
    );
  });
}
