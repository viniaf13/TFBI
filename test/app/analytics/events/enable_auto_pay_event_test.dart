import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/enable_auto_pay_event.dart';

void main() {
  test('EnableAutoPayEvent should have correct properties', () {
    const policyType = 'Life Insurance';
    const policyNumber = '12345';
    const screenName = 'EnableAutoPayScreen';

    final enableAutoPayEvent = EnableAutoPayEvent(
      policyType: policyType,
      policyNumber: policyNumber,
      screenName: screenName,
    );

    expect(enableAutoPayEvent.properties['policy_type'], policyType);
    expect(enableAutoPayEvent.properties['policy_number'], policyNumber);
    expect(enableAutoPayEvent.properties['screen_name'], screenName);
    expect(enableAutoPayEvent.properties['cta'], kEnableAutoPayCta);
  });
}
