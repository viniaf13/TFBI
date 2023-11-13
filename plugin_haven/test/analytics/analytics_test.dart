import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_haven/analytics/analytics.dart';
import 'package:plugin_haven/test/test.dart';

void main() {
  late AnalyticsManager manager;
  late MockAnalyticsProvider analytics;
  const event = MockAnalyticsEvent('mockEvent');

  group('Haven Analytics Tests', () {
    setUp(() {
      analytics = MockAnalyticsProvider();
      manager = AnalyticsManager();
    });
    tearDown(() {
      analytics.clear();
    });

    test('Analytics Event Class', () {
      expect(event, isA<AnalyticsEvent>());
    });

    test('Analytics manager logs event on provider', () async {
      final result = manager.init(null);
      expect(result, isA<Future<void>>());
      manager.add(analytics);
      manager.logEvent(event);
      expect(analytics.events.first, event);
    });

    test('Disable tracking throws exception', () {
      try {
        manager.disableTracking();
        fail('Exception not thrown');
      } catch (e) {
        expect(e, isA<UnsupportedError>());
      }
    });

    test('Analytics provider', () async {
      await analytics.init(null);
      await analytics.disableTracking();
      analytics.update({'user': 'user'});
      analytics.logEvent(event);
      expect(analytics.events.first, event);
    });
  });
}
