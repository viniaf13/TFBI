import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/document_events.dart';

void main() {
  group('ShareDocumentEvent', () {
    test('Event properties are set correctly', () {
      final event = ShareDocumentEvent(
        screenName: 'Test Screen',
        cta: 'Test CTA',
        shareResult: 'Test Result',
      );

      expect(event.properties['screen_name'], 'Test Screen');
      expect(event.properties['cta'], 'Test CTA');
      expect(event.properties['share_result'], 'Test Result');
    });
  });

  group('DocumentEventViewOption', () {
    test('View options have correct values', () {
      expect(
        DocumentEventViewOptions.viewIDCard.value,
        'View ID card',
      );
      expect(
        DocumentEventViewOptions.viewInsuranceCard.value,
        'View insurance card',
      );
      expect(
        DocumentEventViewOptions.viewCurrentBill.value,
        'View current bill',
      );
      expect(
        DocumentEventViewOptions.recurringPaymentSchedule.value,
        'Recurring payment schedule',
      );
    });
  });
}
