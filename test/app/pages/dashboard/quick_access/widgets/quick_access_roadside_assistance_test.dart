import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/roadside_assistance_event.dart';
import 'package:txfb_insurance_flutter/app/analytics/tfb_analytics.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/quick_access/widgets/quick_access_roadside_assistance.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import '../../../../../mocks/mock_tfb_navigator.dart';
import '../../../../../widgets/tfb_widget_tester.dart';
import '../../../../analytics/mock_analytics_provider.dart';

void main() {
  late MockTfbNavigator mockNavigator;
  late MockAnalyticsProvider mockAnalyticsProvider;

  setUp(() {
    mockNavigator = MockTfbNavigator();
    mockAnalyticsProvider = MockAnalyticsProvider();
    TfbAnalytics.instance.add(mockAnalyticsProvider);
    TfbAnalytics.instance.init(const TfbAnalyticsConfig());
    when(
      () => mockNavigator.pushRoadsideAssistancePage(),
    ).thenAnswer((_) => Future<Object?>.value());
  });

  testWidgets(
      'Quick access button roadside assistance, on tap should navigate to roadside assistance page',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        mockNavigator: mockNavigator,
        child: const Column(
          children: [
            QuickAccessRoadsideAssistance(),
          ],
        ),
      ),
    );
    await tester.tap(find.text(AppLocalizationsEn().roadside));
    await tester.pumpAndSettle();
    verify(mockNavigator.pushRoadsideAssistancePage).called(1);
  });

  testWidgets(
      'Quick access button roadside assistance, on tap should fire roadside assistance event',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        mockNavigator: mockNavigator,
        child: const Column(
          children: [
            QuickAccessRoadsideAssistance(),
          ],
        ),
      ),
    );
    await tester.tap(find.text(AppLocalizationsEn().roadside));
    await tester.pumpAndSettle();
    final event = mockAnalyticsProvider.loggedEvents
        .whereType<RoadsideAssistanceEvent>()
        .first;

    expect(
      event.properties['cta'],
      'Roadside assistance',
    );
  });
}
