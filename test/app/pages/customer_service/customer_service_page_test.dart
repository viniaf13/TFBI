import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_haven/environment/environment_notifier.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/cubits/agent_cubit/agent_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/shared/widgets/list_tile_with_arrow.dart';
import 'package:txfb_insurance_flutter/app/pages/customer_service/customer_service_page.dart';
import 'package:txfb_insurance_flutter/app/pages/customer_service/widgets/find_an_office_cta.dart';
import 'package:txfb_insurance_flutter/domain/models/agent_look_up/agent_details.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:txfb_insurance_flutter/shared/widgets/text_with_phone.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import '../../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../../mocks/mock_agent_cubit.dart';
import '../../../mocks/mock_environment_notifier.dart';
import '../../../widgets/tfb_widget_tester.dart';

import 'package:flutter/foundation.dart';
import 'package:txfb_insurance_flutter/shared/constants/strings.dart';

void main() {
  late MockAgentCubit mockAgentCubit;
  late MockEnvironmentNotifier mockEnvironmentNotifier;
  late String launchArguments;
  final MockStatusBarScrollCubit mockStatusBarScrollCubit =
      MockStatusBarScrollCubit();

  setUp(() {
    mockEnvironmentNotifier = MockEnvironmentNotifier();

    mockAgentCubit = MockAgentCubit();
    mocktail.when(() => mockAgentCubit.state).thenReturn(
          AgentDetailsSuccess(
            agentDetails: AgentDetails(
              emailAddress: 'emailAddress',
            ),
          ),
        );
    mocktail
        .when(() => mockStatusBarScrollCubit.state)
        .thenReturn(const StatusBarScrollInitial(''));

    launchArguments = '';
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
            const MethodChannel('plugins.flutter.io/url_launcher'),
            (methodCall) async {
      if (methodCall.method == 'launch') {
        launchArguments = methodCall.arguments.toString();
        return true;
      }
      if (methodCall.method == 'canLaunch') {
        return true;
      }
      return null;
    });
  });

  testWidgets('CustomerServicePage has a title', (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: Scaffold(
          body: ChangeNotifierProvider<EnvironmentNotifier>(
            create: (context) => mockEnvironmentNotifier,
            child: BlocProvider<AgentCubit>.value(
              value: mockAgentCubit,
              child: const CustomerServicePage(),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Contact Customer Service'), findsOneWidget);
  });

  testWidgets('CustomerServicePage displays contact information',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: Scaffold(
          body: ChangeNotifierProvider<EnvironmentNotifier>(
            create: (context) => mockEnvironmentNotifier,
            child: BlocProvider<AgentCubit>.value(
              value: mockAgentCubit,
              child: const CustomerServicePage(),
            ),
          ),
        ),
      ),
    );
    expect(find.text('Customer Service:'), findsOneWidget);
    expect(find.text('Fraud Hotline:'), findsOneWidget);
    expect(find.text('24-Hour Claims Reporting Center:'), findsOneWidget);
    expect(find.text('Roadside Assistance:'), findsOneWidget);
    expect(find.text('Pay by Phone:'), findsOneWidget);
    expect(find.byType(TextWithPhone), findsNWidgets(5));
  });
  testWidgets(
      'CustomerServicePage has a button that opens google maps on Android',
      (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: Scaffold(
          body: ChangeNotifierProvider<EnvironmentNotifier>(
            create: (context) => mockEnvironmentNotifier,
            child: BlocProvider<AgentCubit>.value(
              value: mockAgentCubit,
              child: const CustomerServicePage(),
            ),
          ),
        ),
      ),
    );
    await tester.tap(
      find.widgetWithText(
        ListTileWithArrow,
        AppLocalizationsEn().findAnOfficeCTA,
        skipOffstage: false,
      ),
    );

    await tester.pumpAndSettle();

    expect(
      launchArguments.contains(
        kOfficeLocatorGoogleMaps,
      ),
      isTrue,
    );

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('CustomerServicePage has a button that opens apple maps on iOS',
      (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: Scaffold(
          body: ChangeNotifierProvider<EnvironmentNotifier>(
            create: (context) => mockEnvironmentNotifier,
            child: BlocProvider<AgentCubit>.value(
              value: mockAgentCubit,
              child: const CustomerServicePage(),
            ),
          ),
        ),
      ),
    );
    await tester.tap(
      find.widgetWithText(
        ListTileWithArrow,
        AppLocalizationsEn().findAnOfficeCTA,
        skipOffstage: false,
      ),
    );
    await tester.pumpAndSettle();
    expect(
      launchArguments.contains(
        kOfficeLocatorAppleMaps,
      ),
      isTrue,
    );

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('CustomerServicePage has a button that opens a draft email',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: Scaffold(
          body: ChangeNotifierProvider<EnvironmentNotifier>(
            create: (context) => mockEnvironmentNotifier,
            child: BlocProvider<AgentCubit>.value(
              value: mockAgentCubit,
              child: const CustomerServicePage(),
            ),
          ),
        ),
      ),
    );
    await tester.tap(
      find.widgetWithText(
        ListTileWithArrow,
        AppLocalizationsEn().emailUsCTA,
        skipOffstage: false,
      ),
    );
    await tester.pumpAndSettle();
    expect(
      launchArguments.contains(
        'mailto:emailAddress',
      ),
      isTrue,
    );
  });
  testWidgets('When unable to open maps app, should show snackbar',
      (tester) async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
            const MethodChannel('plugins.flutter.io/url_launcher'),
            (methodCall) async {
      if (methodCall.method == 'canLaunch') {
        return false;
      }
      return null;
    });

    await tester.pumpWidget(
      const TfbWidgetTester(
        child: Scaffold(
          body: FindAnOfficeCTA(),
        ),
      ),
    );
    await tester.tap(
      find.byType(GestureDetector),
    );
    await tester.pumpAndSettle();

    expect(
      find.text(AppLocalizationsEn().officeLocatorError),
      findsOneWidget,
    );
  });
}
