import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:plugin_haven/environment/environment_notifier.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claims_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/agent_cubit/agent_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/auto_policy/auto_policy_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/auto_policy_document/auto_policy_document_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/paperless_lookup/paperless_lookup_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/save_auto_id_card/save_auto_id_card_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/wallet/wallet_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/policy_detail_page.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/insurance_card_content.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_card.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_claims_card/policy_detail_claims_card.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_widgets.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/vehicles_detail/policy_detail_vehicles.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment_dev.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/paperless/paperless_lookup_response.dart';
import 'package:txfb_insurance_flutter/domain/models/models.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/member_summary.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_list_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/agent_card/agent_card.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';

import '../../../../mocks/bloc/mock_auth_bloc.dart';
import '../../../../mocks/bloc/mock_claims_bloc.dart';
import '../../../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../../../mocks/bloc/mock_wallet_cubit.dart';
import '../../../../mocks/mock_agent_cubit.dart';
import '../../../../mocks/mock_auto_policy.dart';
import '../../../../mocks/mock_auto_policy_document_cubit.dart';
import '../../../../mocks/mock_environment_notifier.dart';
import '../../../../mocks/mock_member_summary.dart';
import '../../../../mocks/mock_policy_lookup_client.dart';
import '../../../../mocks/mock_save_auto_id_card.dart';
import '../../../../mocks/mock_tfb_policy_lookup_repository.dart';
import '../../../../mocks/mock_tfb_user.dart';
import '../../../../widgets/tfb_widget_tester.dart';
import '../../../cubits/billing/paperless_lookup/mock_paperless_lookup_cubit.dart';

final agentDetails = AgentDetails(
  firstName: 'FirstName',
  lastName: 'LastName',
  emailAddress: 'emailAddress',
  phoneNumber: 'phoneNumber',
  titleDesignation: 'titleDesignation',
  photo: '',
);

void main() {
  final TfbUser testUser = MockTfbUser();

  late MockMemberSummaryCubit memberSummaryCubit;
  late MockAutoPolicyCubit autoPolicyCubit;
  late MockSaveAutoIdCardCubit saveAutoIdCardCubit;
  late MockAgentCubit agentCubit;
  late MockClaimsBloc mockClaimsBloc;
  late MockAuthBloc authBloc;
  late MockEnvironmentNotifier mockEnvironmentNotifier;
  late MockWalletCubit walletCubit;
  late MockAutoPolicyDocumentCubit policyDocumentCubit;
  late MockPaperlessLookupCubit mockPaperlessLookupCubit;
  late MockTfbPolicyLookupRepository mockTfbPolicyLookupRepository;
  late MockStatusBarScrollCubit mockStatusBarScrollCubit;

  setUpAll(() {
    mocktail.registerFallbackValue(FakeMemberSummaryState());
    mocktail.registerFallbackValue(FakeAutoPolicyState());
    mocktail.registerFallbackValue(FakeSaveAutoIdCardState());
    mocktail.registerFallbackValue(FakeAgentState());
    mocktail.registerFallbackValue(FakeAutoPolicyDocumentState());
  });

  setUp(() {
    memberSummaryCubit = MockMemberSummaryCubit();
    autoPolicyCubit = MockAutoPolicyCubit();
    saveAutoIdCardCubit = MockSaveAutoIdCardCubit();
    agentCubit = MockAgentCubit();
    authBloc = MockAuthBloc();
    mockEnvironmentNotifier = MockEnvironmentNotifier();
    walletCubit = MockWalletCubit();
    mockClaimsBloc = MockClaimsBloc();
    policyDocumentCubit = MockAutoPolicyDocumentCubit();
    mockPaperlessLookupCubit = MockPaperlessLookupCubit();
    mockStatusBarScrollCubit = MockStatusBarScrollCubit();
    mockTfbPolicyLookupRepository = MockTfbPolicyLookupRepository();

    mocktail.when(() => walletCubit.state).thenReturn(WalletInitial());

    mocktail.when(() => authBloc.state).thenReturn(
          AuthSignedIn(testUser),
        );

    mocktail.when(() => mockEnvironmentNotifier.environment).thenReturn(
          TfbEnvironmentDev(),
        );
    mocktail.when(() => mockClaimsBloc.state).thenReturn(
          ClaimsProcessingState(isPullToRefresh: false),
        );
    mocktail.when(() => mockPaperlessLookupCubit.state).thenReturn(
          PaperlessLookupSuccessState(
            response: PaperlessLookupResponse(memberEmailAddress: ''),
          ),
        );
    mocktail
        .when(() => mockStatusBarScrollCubit.state)
        .thenReturn(const StatusBarScrollInitial(''));
  });

  testWidgets('Policy details loading state', (tester) async {
    final mockPolicy = MockPolicy.createPolicySummary();

    mocktail
        .when(() => agentCubit.getAgent(mocktail.any<String>()))
        .thenAnswer((_) => Future.value());

    mocktail.when(() => memberSummaryCubit.state).thenReturn(
          MemberSummarySuccess(
            memberSummary: MemberSummary(
              policies: [
                mockPolicy,
              ],
            ),
          ),
        );

    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<MemberSummaryCubit>.value(
              value: memberSummaryCubit,
            ),
            BlocProvider<AgentCubit>.value(value: agentCubit),
          ],
          child: PolicyDetailPage(mockPolicy),
        ),
      ),
    );

    expect(find.byType(TfbBrandLoadingIcon), findsOneWidget);
  });

  testWidgets('Policy details missing policy details state', (tester) async {
    final mockPolicy = MockPolicy.createPolicySummary();
    final mockHomeownersDetail = MockPolicy.createHomeownerPolicyDetail();

    mocktail
        .when(() => agentCubit.getAgent(mocktail.any<String>()))
        .thenAnswer((_) => Future.value());

    mocktail.when(() => memberSummaryCubit.state).thenReturn(
          MemberSummaryDetailsSuccess(
            memberSummary: MemberSummary(
              policies: [
                mockPolicy,
              ],
            ),
            policyMap: {'00000': mockHomeownersDetail},
            error: TfbRequestError(),
          ),
        );

    mocktail.when(() => agentCubit.state).thenReturn(
          AgentDetailsSuccess(
            agentDetails: MockAgentDetails(),
          ),
        );

    await tester.pumpWidget(
      Provider<TfbPolicyLookupRepository>(
        create: (_) => mockTfbPolicyLookupRepository,
        child: TfbWidgetTester(
          mockStatusBarScrollCubit: mockStatusBarScrollCubit,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<MemberSummaryCubit>(
                create: (context) => memberSummaryCubit,
              ),
              BlocProvider<AgentCubit>(
                create: (context) => agentCubit,
              ),
              BlocProvider<WalletCubit>(
                create: (_) => walletCubit,
              ),
              BlocProvider<ClaimsBloc>(
                create: (context) => mockClaimsBloc,
              ),
            ],
            child: PolicyDetailPage(mockPolicy),
          ),
        ),
      ),
    );

    expect(find.byType(PolicyDetailCard), findsNothing);
  });

  testWidgets(
      'Policy details policy lists expected details cards, insurance card and agent card',
      (tester) async {
    final mockPolicy =
        MockPolicy.createPolicySummary(policyType: PolicyType.txPersonalAuto);
    final mockAutoDetail = MockPolicy.createAutoPolicyDetail(
      policyNum: mockPolicy.policyNumber,
    );

    mocktail
        .when(() => autoPolicyCubit.getPersonalAutoPolicy(mockPolicy))
        .thenAnswer((_) => Future.value());

    mocktail
        .when(() => saveAutoIdCardCubit.getIsIdCardSaved(mockPolicy))
        .thenAnswer((_) => Future.value());

    mocktail
        .when(() => policyDocumentCubit.getPolicyDocumentList(mockPolicy))
        .thenAnswer((_) => Future.value());

    mocktail
        .when(() => agentCubit.getAgent('1234'))
        .thenAnswer((_) => Future.value());

    mocktail.when(() => autoPolicyCubit.state).thenReturn(
          AutoPolicySuccess(
            autoPolicyDetail: mockAutoDetail,
          ),
        );
    mocktail.when(() => saveAutoIdCardCubit.state).thenReturn(
          const SaveAutoIdCardInitial(),
        );

    mocktail.when(() => policyDocumentCubit.state).thenReturn(
          const AutoPolicyDocumentSuccess(
            policyDocuments: <PolicyListMetadata>[],
            policyStaticDocuments: [],
          ),
        );

    mocktail.when(() => memberSummaryCubit.state).thenReturn(
          MemberSummaryDetailsSuccess(
            memberSummary: MemberSummary(
              policies: [
                mockPolicy,
              ],
            ),
            policyMap: {mockAutoDetail.policyNumber: mockAutoDetail},
          ),
        );

    mocktail.when(() => agentCubit.state).thenReturn(
          AgentDetailsSuccess(
            agentDetails: agentDetails,
          ),
        );

    WalletCardPlatform.instance = IosWalletCard();

    await tester.pumpWidget(
      Provider<TfbPolicyLookupRepository>(
        create: (_) => mockTfbPolicyLookupRepository,
        child: TfbWidgetTester(
          mockStatusBarScrollCubit: mockStatusBarScrollCubit,
          child: ChangeNotifierProvider<EnvironmentNotifier>(
            create: (context) => mockEnvironmentNotifier,
            child: MultiBlocProvider(
              providers: [
                BlocProvider<PaperlessLookupCubit>(
                  create: (context) => mockPaperlessLookupCubit,
                ),
                BlocProvider<AuthBloc>(
                  create: (context) => authBloc,
                ),
                BlocProvider<MemberSummaryCubit>(
                  create: (context) => memberSummaryCubit,
                ),
                BlocProvider<AutoPolicyCubit>(
                  create: (context) => autoPolicyCubit,
                ),
                BlocProvider<SaveAutoIdCardCubit>(
                  create: (context) => saveAutoIdCardCubit,
                ),
                BlocProvider<AgentCubit>(
                  create: (context) => agentCubit,
                ),
                BlocProvider<WalletCubit>(
                  create: (_) => walletCubit,
                ),
                BlocProvider<ClaimsBloc>(
                  create: (context) => mockClaimsBloc,
                ),
                BlocProvider<AutoPolicyDocumentCubit>(
                  create: (context) => policyDocumentCubit,
                ),
              ],
              child: PolicyDetailPage(mockPolicy),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(PolicyDetailOverview), findsOneWidget);
    expect(find.byType(InsuranceCardContent), findsOneWidget);

    await tester.scrollUntilVisible(
      find.byType(PolicyDetailPolicyHolder),
      100,
    );
    await tester.pumpAndSettle();

    expect(
      find.textContaining(mockAutoDetail.namedInsuredOne!.toTitleCase()),
      findsOneWidget,
    );
    expect(find.byType(PolicyDetailPolicyHolder), findsOneWidget);
    expect(
      find.textContaining(', ${mockAutoDetail.namedInsuredTwo!.toTitleCase()}'),
      findsOneWidget,
    );
    expect(
      find.text(mockAutoDetail.policyAddress.cityStateZip),
      findsOneWidget,
    );

    await tester.scrollUntilVisible(
      find.byType(PolicyDetailDrivers),
      100,
    );
    await tester.pumpAndSettle();

    expect(find.byType(PolicyDetailDrivers), findsOneWidget);

    await tester.scrollUntilVisible(
      find.byType(PolicyDetailVehicles),
      100,
    );
    await tester.pumpAndSettle();

    expect(find.byType(PolicyDetailVehicles), findsOneWidget);

    await tester.scrollUntilVisible(find.byType(PolicyDetailClaimsCard), 100);
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.byType(AgentCard), 100);
    await tester.pumpAndSettle();

    expect(find.byType(AgentCard), findsOneWidget);
  });

  testWidgets(
      'Member Summary display SnackBar when state of MemberSummary is failure',
      (WidgetTester tester) async {
    final mockPolicy =
        MockPolicy.createPolicySummary(policyType: PolicyType.txPersonalAuto);

    final mockAutoDetail = MockPolicy.createAutoPolicyDetail(
      policyNum: mockPolicy.policyNumber,
    );

    final expectedStates = [MemberSummaryFailure(error: TfbRequestError())];

    whenListen(memberSummaryCubit, Stream.fromIterable(expectedStates));

    mocktail
        .when(() => memberSummaryCubit.state)
        .thenReturn(MemberSummaryFailure(error: TfbRequestError()));

    mocktail.when(() => agentCubit.state).thenReturn(
          AgentDetailsSuccess(
            agentDetails: agentDetails,
          ),
        );

    mocktail.when(() => autoPolicyCubit.state).thenReturn(
          AutoPolicySuccess(
            autoPolicyDetail: mockAutoDetail,
          ),
        );

    mocktail.when(() => saveAutoIdCardCubit.state).thenReturn(
          const SaveAutoIdCardInitial(),
        );

    mocktail
        .when(() => autoPolicyCubit.getPersonalAutoPolicy(mockPolicy))
        .thenAnswer((_) => Future.value());

    mocktail
        .when(() => saveAutoIdCardCubit.getIsIdCardSaved(mockPolicy))
        .thenAnswer((_) => Future.value());

    mocktail
        .when(
          () => agentCubit.getAgent(mocktail.any<String>()),
        )
        .thenAnswer((_) => Future.value());

    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<MemberSummaryCubit>(
              create: (context) => memberSummaryCubit,
            ),
            BlocProvider<AutoPolicyCubit>(
              create: (context) => autoPolicyCubit,
            ),
            BlocProvider<SaveAutoIdCardCubit>(
              create: (context) => saveAutoIdCardCubit,
            ),
            BlocProvider<AgentCubit>(
              create: (context) => agentCubit,
            ),
          ],
          child: PolicyDetailPage(mockPolicy),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(TfbSnackbarContent), findsOneWidget);
  });
}

class MockAgentDetails extends mocktail.Mock implements AgentDetails {}
