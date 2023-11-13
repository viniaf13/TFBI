import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:mocktail/mocktail.dart';
import 'package:plugin_haven/environment/environment_notifier.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/cubits/agent_cubit/agent_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/dashboard.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/support/customer_service_card_button.dart';
import 'package:txfb_insurance_flutter/device/device.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/login/login_member.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/widgets/decorated_failure_container.dart';

import '../../../../mocks/bloc/mock_auth_bloc.dart';
import '../../../../mocks/mock_agent_cubit.dart';
import '../../../../mocks/mock_environment_notifier.dart';
import '../../../../mocks/mock_tfb_navigator.dart';
import '../../../../widgets/tfb_widget_tester.dart';

final TfbUser testUser = TfbUser(
  accessToken: 'testAccessToken',
  username: 'username',
  agentNumber: 'agentNumber',
  communicationPreferred: 'communicationPreferred',
  emailVerified: true,
  errorMessage: 'errorMessage',
  memberName: 'memberName',
  memberSecondaryName: 'memberSecondaryName',
  passwordResetFlag: false,
  sessionCookie: 'sessionCookie',
  memberEmailAddress: 'memberEmailAddress',
  members: [
    LoginMember(
      lastLoginTimestamp: 'lastLoginTimestamp',
      memberIDNumber: 1234,
      memberNumber: '1234',
    ),
  ],
);

void main() {
  late MockAgentCubit mockAgentCubit;
  late MockAuthBloc mockAuthBloc;
  late MockEnvironmentNotifier mockEnvironmentNotifier;
  late MockTfbNavigator mockNavigator;

  setUpAll(() {
    mocktail.registerFallbackValue(FakeAgentState());
  });

  setUp(() {
    mockAgentCubit = MockAgentCubit();
    mockAuthBloc = MockAuthBloc();
    mockEnvironmentNotifier = MockEnvironmentNotifier();
    mockNavigator = MockTfbNavigator();
    mocktail.when(() => mockEnvironmentNotifier.environment).thenReturn(
          TfbEnvironmentDev(),
        );
    mocktail.when(() => mockAgentCubit.state).thenReturn(
          AgentInitial(),
        );
    mocktail.when(() => mockAuthBloc.state).thenReturn(
          AuthSignedIn(testUser),
        );
    mocktail
        .when(() => mockAgentCubit.getAgent('1234'))
        .thenAnswer((_) async => ());
  });

  testWidgets('renders SupportDashSection when AgentDetailsSuccess',
      (tester) async {
    final agentDetails = AgentDetails(
      firstName: 'FirstName',
      lastName: 'LastName',
      emailAddress: 'emailAddress',
      phoneNumber: 'phoneNumber',
      titleDesignation: 'titleDesignation',
      photo: '',
    );
    mocktail.when(() => mockAgentCubit.state).thenReturn(
          AgentDetailsSuccess(
            agentDetails: agentDetails,
          ),
        );

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: ChangeNotifierProvider<EnvironmentNotifier>(
            create: (context) => mockEnvironmentNotifier,
            child: BlocProvider<AuthBloc>.value(
              value: mockAuthBloc,
              child: BlocProvider<AgentCubit>.value(
                value: mockAgentCubit,
                child: const SupportSection(),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(SupportDashSection), findsOneWidget);
    expect(find.byType(CustomerServiceCardButton), findsOneWidget);
  });

  testWidgets('renders SizedBox.shrink when AgentCodeSuccess', (tester) async {
    mocktail.when(() => mockAgentCubit.state).thenReturn(AgentCodeSuccess());

    await tester.pumpWidget(
      TfbWidgetTester(
        child: ChangeNotifierProvider<EnvironmentNotifier>(
          create: (context) => mockEnvironmentNotifier,
          child: BlocProvider<AuthBloc>.value(
            value: mockAuthBloc,
            child: BlocProvider<AgentCubit>.value(
              value: mockAgentCubit,
              child: const SupportSection(),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(SupportDashSection), findsOneWidget);
  });

  testWidgets('Support section displays error message on api failure',
      (tester) async {
    mocktail
        .when(() => mockAgentCubit.state)
        .thenReturn(AgentFailure(error: TfbRequestError()));

    await tester.pumpWidget(
      TfbWidgetTester(
        child: ChangeNotifierProvider<EnvironmentNotifier>(
          create: (context) => mockEnvironmentNotifier,
          child: BlocProvider<AuthBloc>.value(
            value: mockAuthBloc,
            child: BlocProvider<AgentCubit>.value(
              value: mockAgentCubit,
              child: const SupportSection(),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(DecoratedFailureContainer), findsOneWidget);
  });

  testWidgets(
      'On tap customer service cta should navigate to customer service page',
      (tester) async {
    when(mockNavigator.pushCustomerServicePage)
        .thenAnswer((invocation) => Future<void>.value());
    await tester.pumpWidget(
      TfbWidgetTester(
        mockNavigator: mockNavigator,
        child: ChangeNotifierProvider<EnvironmentNotifier>(
          create: (context) => mockEnvironmentNotifier,
          child: BlocProvider<AuthBloc>.value(
            value: mockAuthBloc,
            child: BlocProvider<AgentCubit>.value(
              value: mockAgentCubit,
              child: const SupportSection(),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.byType(CustomerServiceCardButton));
    await tester.pumpAndSettle();

    verify(() => mockNavigator.pushCustomerServicePage()).called(1);
  });
}
