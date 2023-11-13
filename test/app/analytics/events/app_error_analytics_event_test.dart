import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/app_error_analytics_event.dart';

void main() {
  test('AppErrorEvent should have correct properties', () {
    const error = 'Sample error message';

    final appErrorEvent = AppErrorEvent(error: error);

    expect(
      appErrorEvent.properties['error_message'],
      error,
    );
  });
}
