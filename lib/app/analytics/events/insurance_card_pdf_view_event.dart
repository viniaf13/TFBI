import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';

const kInsuranceCardPdfViewEvent = 'insurance_card_pdf_view';

class InsuranceCardPdfViewEvent extends TfbAnalyticsEvent {
  const InsuranceCardPdfViewEvent() : super(kInsuranceCardPdfViewEvent);
}
