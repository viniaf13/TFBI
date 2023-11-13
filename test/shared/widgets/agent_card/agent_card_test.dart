import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_haven/environment/environment_notifier.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/cubits/agent_cubit/agent_cubit.dart';
import 'package:txfb_insurance_flutter/device/device.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/agent_card/agent_card.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_email.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_phone.dart';

import '../../../mocks/mock_agent_cubit.dart';
import '../../../mocks/mock_environment_notifier.dart';
import '../../../widgets/tfb_widget_tester.dart';
import '../../../mocks/mock_http_overrides.dart';

class MockAgentDetails extends Mock implements AgentDetails {}

void main() {
  late MockAgentDetails mockAgentDetails;
  late MockEnvironmentNotifier mockEnvironmentNotifier;
  late MockAgentCubit mockAgentCubit;

  setUp(() async {
    mockAgentDetails = MockAgentDetails();
    mockEnvironmentNotifier = MockEnvironmentNotifier();
    mockAgentCubit = MockAgentCubit();
    when(() => mockEnvironmentNotifier.environment).thenReturn(
      TfbEnvironmentDev(),
    );
    when(() => mockAgentCubit.state).thenReturn(
      AgentDetailsSuccess(
        agentDetails: mockAgentDetails,
      ),
    );

    registerFallbackValue(Uri());

    final imageByteData = await rootBundle.load(TfbAssetStrings.starIcon);
    final imageIntList = imageByteData.buffer.asInt8List();

    final requestsMap = {
      Uri.parse('https://wwwstg.txfb-ins.com/agentphotos/12345.jpg'):
          imageIntList,
    };

    HttpOverrides.global = MockHttpOverrides(requestsMap);
  });

  bool isCachedNetworkImageWidget(Widget widget) =>
      widget is CachedNetworkImage;

  testWidgets(
      'SupportCardAgent should render correctly with photo string empty',
      (tester) async {
    HttpOverrides.runZoned(
      () async {
        when(() => mockAgentDetails.firstAndLastName).thenReturn('John Doe');
        when(() => mockAgentDetails.getTitleDesignation).thenReturn('Agent');
        when(() => mockAgentDetails.photo).thenReturn('');
        when(() => mockAgentDetails.hasPhone).thenReturn(true);
        when(() => mockAgentDetails.hasEmail).thenReturn(true);
        when(() => mockAgentDetails.phoneNumber).thenReturn('123-456-7890');
        when(() => mockAgentDetails.emailAddress)
            .thenReturn('john.doe@example.com');

        await tester.pumpWidget(
          TfbWidgetTester(
            child: Scaffold(
              body: ChangeNotifierProvider<EnvironmentNotifier>(
                create: (context) => mockEnvironmentNotifier,
                child: BlocProvider<AgentCubit>.value(
                  value: mockAgentCubit,
                  child: const AgentCard(),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ExpansionTile));

        await tester.pumpAndSettle();

        expect(find.text('John Doe'), findsOneWidget);
        expect(find.text('Agent'), findsOneWidget);
        expect(find.byType(ExpansionTile), findsOneWidget);
        expect(find.byType(TextWithPhone), findsOneWidget);
        expect(find.byType(TextWithEmail), findsOneWidget);
      },
    );
  });
  testWidgets('SupportCardAgent should render correctly with photo is null',
      (tester) async {
    HttpOverrides.runZoned(
      () async {
        when(() => mockAgentDetails.firstAndLastName).thenReturn('John Doe');
        when(() => mockAgentDetails.getTitleDesignation).thenReturn('Agent');
        when(() => mockAgentDetails.photo).thenReturn(null);
        when(() => mockAgentDetails.hasPhone).thenReturn(true);
        when(() => mockAgentDetails.hasEmail).thenReturn(true);
        when(() => mockAgentDetails.phoneNumber).thenReturn('123-456-7890');
        when(() => mockAgentDetails.emailAddress)
            .thenReturn('john.doe@example.com');

        await tester.pumpWidget(
          TfbWidgetTester(
            child: Scaffold(
              body: ChangeNotifierProvider<EnvironmentNotifier>(
                create: (context) => mockEnvironmentNotifier,
                child: BlocProvider<AgentCubit>.value(
                  value: mockAgentCubit,
                  child: const AgentCard(),
                ),
              ),
            ),
          ),
        );

        expect(find.text('John Doe'), findsOneWidget);
        expect(find.text('Agent'), findsOneWidget);
        expect(
          find.byWidgetPredicate(isCachedNetworkImageWidget),
          findsOneWidget,
        );
        expect(find.byType(ExpansionTile), findsOneWidget);
      },
    );
  });

  testWidgets('SupportCardAgent should render correctly with photo',
      (tester) async {
    HttpOverrides.runZoned(
      () async {
        when(() => mockAgentDetails.firstAndLastName).thenReturn('John Doe');
        when(() => mockAgentDetails.getTitleDesignation).thenReturn('Agent');
        when(() => mockAgentDetails.photo).thenReturn('/agentphotos/12345.jpg');
        when(() => mockAgentDetails.hasPhone).thenReturn(true);
        when(() => mockAgentDetails.hasEmail).thenReturn(true);
        when(() => mockAgentDetails.phoneNumber).thenReturn('123-456-7890');
        when(() => mockAgentDetails.emailAddress)
            .thenReturn('john.doe@example.com');

        await tester.pumpWidget(
          TfbWidgetTester(
            child: Scaffold(
              body: ChangeNotifierProvider<EnvironmentNotifier>(
                create: (context) => mockEnvironmentNotifier,
                child: BlocProvider<AgentCubit>.value(
                  value: mockAgentCubit,
                  child: const AgentCard(),
                ),
              ),
            ),
          ),
        );

        expect(find.text('John Doe'), findsOneWidget);
        expect(find.text('Agent'), findsOneWidget);
        expect(
          find.byWidgetPredicate(isCachedNetworkImageWidget),
          findsOneWidget,
        );
        expect(find.byType(ExpansionTile), findsOneWidget);
      },
    );
  });
  testWidgets('SupportCardAgent should render correctly', (tester) async {
    HttpOverrides.runZoned(
      () async {
        when(() => mockAgentDetails.firstAndLastName).thenReturn('John Doe');
        when(() => mockAgentDetails.getTitleDesignation).thenReturn('Agent');
        when(() => mockAgentDetails.photo).thenReturn('');
        when(() => mockAgentDetails.hasPhone).thenReturn(true);
        when(() => mockAgentDetails.hasEmail).thenReturn(true);
        when(() => mockAgentDetails.phoneNumber).thenReturn('123-456-7890');
        when(() => mockAgentDetails.emailAddress)
            .thenReturn('john.doe@example.com');

        await tester.pumpWidget(
          TfbWidgetTester(
            child: Scaffold(
              body: ChangeNotifierProvider<EnvironmentNotifier>(
                create: (context) => mockEnvironmentNotifier,
                child: BlocProvider<AgentCubit>.value(
                  value: mockAgentCubit,
                  child: const AgentCard(),
                ),
              ),
            ),
          ),
        );

        expect(find.text('John Doe'), findsOneWidget);
        expect(find.text('Agent'), findsOneWidget);
        expect(
          find.byWidgetPredicate(isCachedNetworkImageWidget),
          findsOneWidget,
        );
        expect(find.byType(ExpansionTile), findsOneWidget);
      },
    );
  });

  testWidgets('SupportCardAgent should handle missing phone and email',
      (tester) async {
    HttpOverrides.runZoned(
      () async {
        when(() => mockAgentDetails.firstAndLastName).thenReturn('John Doe');
        when(() => mockAgentDetails.getTitleDesignation).thenReturn('Agent');
        when(() => mockAgentDetails.photo).thenReturn('');
        when(() => mockAgentDetails.hasPhone).thenReturn(false);
        when(() => mockAgentDetails.hasEmail).thenReturn(false);
        when(() => mockAgentDetails.phoneNumber).thenReturn(null);
        when(() => mockAgentDetails.emailAddress).thenReturn(null);

        await tester.pumpWidget(
          TfbWidgetTester(
            child: Scaffold(
              body: ChangeNotifierProvider<EnvironmentNotifier>(
                create: (context) => mockEnvironmentNotifier,
                child: BlocProvider<AgentCubit>.value(
                  value: mockAgentCubit,
                  child: const AgentCard(),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ExpansionTile));

        await tester.pumpAndSettle();

        expect(find.text('John Doe'), findsOneWidget);
        expect(find.text('Agent'), findsOneWidget);
        expect(
          find.byWidgetPredicate(isCachedNetworkImageWidget),
          findsOneWidget,
        );
        expect(find.byType(ExpansionTile), findsOneWidget);
        expect(find.byType(TextWithPhone), findsNothing);
        expect(find.byType(TextWithEmail), findsNothing);
      },
    );
  });
}
