import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_haven/environment/environment_notifier.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/device/device.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

import '../mocks/bloc/mock_auth_bloc.dart';
import '../mocks/mock_environment_notifier.dart';
import 'tfb_widget_tester.dart';

void main() {
  testWidgets('Dev modal displays all switch environment buttons',
      (widgetTester) async {
    final mockEnvironmentNotifier = MockEnvironmentNotifier();
    when(() => mockEnvironmentNotifier.environment)
        .thenReturn(TfbEnvironmentDev());

    final mockAuthBloc = MockAuthBloc();
    when(() => mockAuthBloc.state).thenReturn(AuthSignedOut());

    await widgetTester.pumpWidget(
      ChangeNotifierProvider<EnvironmentNotifier>(
        create: (context) => mockEnvironmentNotifier,
        child: TfbWidgetTester(
          mockAuthBloc: mockAuthBloc,
          child: const DevUtilsModal(),
        ),
      ),
    );

    expect(find.text('Switch to dev'), findsOneWidget);
    expect(find.text('Switch to prod'), findsOneWidget);
    expect(find.text('Switch to stage'), findsOneWidget);
    expect(find.text('Switch to device preview'), findsOneWidget);
  });

  testWidgets(
      'Tapping the environment switching buttons calls the environment notifier provider each time',
      (widgetTester) async {
    final mockEnvironmentNotifier = MockEnvironmentNotifier();
    when(() => mockEnvironmentNotifier.environment)
        .thenReturn(TfbEnvironmentDev());

    final mockAuthBloc = MockAuthBloc();
    when(() => mockAuthBloc.state).thenReturn(AuthSignedOut());

    await widgetTester.pumpWidget(
      ChangeNotifierProvider<EnvironmentNotifier>(
        create: (context) => mockEnvironmentNotifier,
        child: TfbWidgetTester(
          mockAuthBloc: mockAuthBloc,
          child: const DevUtilsModal(),
        ),
      ),
    );

    final candidates = find.byType(TfbFilledButton);
    const environmentCount = 4;

    for (var i = 0; i < environmentCount; i++) {
      await widgetTester.tap(candidates.at(i));
    }

    verify(() => mockEnvironmentNotifier.environment = any())
        .called(environmentCount);
  });

  testWidgets('Dev modal displays Simulate Errors buttons', (tester) async {
    final mockEnvironmentNotifier = MockEnvironmentNotifier();
    when(() => mockEnvironmentNotifier.environment)
        .thenReturn(TfbEnvironmentDev());

    final mockAuthBloc = MockAuthBloc();
    when(() => mockAuthBloc.state).thenReturn(AuthSignedOut());

    await tester.pumpWidget(
      ChangeNotifierProvider<EnvironmentNotifier>(
        create: (context) => mockEnvironmentNotifier,
        child: TfbWidgetTester(
          mockAuthBloc: mockAuthBloc,
          child: const DevUtilsModal(),
        ),
      ),
    );

    final listViewFinder = find.byType(ListView);
    await tester.ensureVisible(listViewFinder);
    await tester.drag(listViewFinder, const Offset(0, -300));
    await tester.pumpAndSettle();

    expect(
      find.text(AppLocalizationsEn().devUtilsSimulateErrors),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().devUtilsThrowTestException),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().devUtilsCrashTest),
      findsOneWidget,
    );
  });
}
