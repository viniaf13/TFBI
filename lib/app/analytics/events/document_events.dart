import 'package:txfb_insurance_flutter/app/analytics/events/tfb_analytics_event.dart';

const kShareDocumentEvent = 'share_document';

enum DocumentEventViewOptions {
  viewIDCard('View ID card'),
  viewInsuranceCard('View insurance card'),
  viewCurrentBill('View current bill'),
  recurringPaymentSchedule('Recurring payment schedule');

  const DocumentEventViewOptions(this.value);

  final String value;
}

class ShareDocumentEvent extends TfbAnalyticsEvent {
  ShareDocumentEvent({
    required String screenName,
    required String cta,
    required String shareResult,
  }) : super(
          kShareDocumentEvent,
          properties: {
            'screen_name': screenName,
            'cta': cta,
            'share_result': shareResult,
          },
        );
}
