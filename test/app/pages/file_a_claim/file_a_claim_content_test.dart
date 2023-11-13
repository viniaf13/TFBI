import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_haven/auth/auth_bloc.dart';
import 'package:plugin_haven/environment/environment_notifier.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim/file_a_claim_page_content.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment_dev.dart';
import 'package:txfb_insurance_flutter/domain/models/login/login_member.dart';
import 'package:txfb_insurance_flutter/domain/models/login/tfb_user.dart';
import 'package:timezone/data/latest.dart' as tz;
import '../../../mocks/bloc/mock_auth_bloc.dart';
import '../../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../../mocks/mock_environment_notifier.dart';
import '../../../mocks/mock_submit_claim_bloc.dart';
import '../../../widgets/tfb_widget_tester.dart';

void main() {
  late MockSubmitClaimBloc submitClaimBloc;
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

  setUp(
    () {
      registerFallbackValue(SubmitClaimInitState());
      submitClaimBloc = MockSubmitClaimBloc();
      tz.initializeTimeZones();
      when(() => submitClaimBloc.state).thenReturn(SubmitClaimInitState());
    },
  );

  testWidgets('File A Claim section should render content', (tester) async {
    final AuthBloc mockAuthBloc = MockAuthBloc();
    when(() => mockAuthBloc.state).thenReturn(AuthSignedIn(testUser));
    final MockEnvironmentNotifier mockEnvironmentNotifier =
        MockEnvironmentNotifier();
    when(() => mockEnvironmentNotifier.environment).thenReturn(
      TfbEnvironmentDev(),
    );
    final mockStatusBarScrollCubit = MockStatusBarScrollCubit();
    when(() => mockStatusBarScrollCubit.state)
        .thenReturn(const StatusBarScrollInitial(''));

    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: ChangeNotifierProvider<EnvironmentNotifier>(
          create: (context) => mockEnvironmentNotifier,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>.value(
                value: mockAuthBloc,
              ),
              BlocProvider<SubmitClaimBloc>.value(
                value: submitClaimBloc,
              ),
            ],
            child: const FileAClaimPageContent(),
          ),
        ),
      ),
    );

    expect(
      find.text(AppLocalizationsEn().claimsFileAClaimCardTitle),
      findsOneWidget,
    );
    expect(
      find.text(
        'Call our 24 hour claims representative at 8002665458 or contact your agent.',
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        '${AppLocalizationsEn().claimsFileAClaimCardTextBegin}8002665458${AppLocalizationsEn().claimsFileAClaimCardTextEnd}',
      ),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().claimsBeginClaimCTA),
      findsOneWidget,
    );
  });
}
