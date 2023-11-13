import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/tfb_analytics_event.dart';

void main() {
  test('TfbAnalyticsEvent toJson should return properties', () {
    const eventName = 'SampleEvent';
    final properties = {
      'property1': 'value1',
      'property2': 'value2',
    };
    final tfbAnalyticsEvent = TfbAnalyticsEvent(
      eventName,
      properties: properties,
    );

    final result = tfbAnalyticsEvent.toJson();

    expect(result, properties);
  });
}
