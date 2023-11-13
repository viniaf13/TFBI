import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/insurance_card_event.dart';

void main() {
  group('InsuranceCardOfflineToggleActiveEvent', () {
    test('creates event with correct properties', () {
      final event = InsuranceCardOfflineToggleActiveEvent(
        'Auto Policy',
        '123456789',
        'Screen Name',
      );

      expect(
        event.name,
        kiInsuranceCardOfflineToggleActiveEvent,
      );
      expect(
        event.properties['policy_type'],
        'Auto Policy',
      );
      expect(
        event.properties['policy_number'],
        '123456789',
      );
      expect(
        event.properties['screen_name'],
        'Screen Name',
      );
      expect(
        event.properties['cta'],
        'Make insurance card available offline',
      );
    });
  });

  group('ViewIdCardEvent', () {
    test('creates event with correct properties', () {
      final event = ViewIdCardEvent('Screen name');

      expect(
        event.name,
        kViewIdCardEvent,
      );
      expect(
        event.properties['screen_name'],
        'Screen name',
      );
      expect(
        event.properties['cta'],
        'View ID card',
      );
    });
  });
}
