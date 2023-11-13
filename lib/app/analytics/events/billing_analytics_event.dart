import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';

const kBillingLandingPageEvent = 'billing_landing_screen_view';

class BillingLandingPageEvent extends TfbAnalyticsEvent {
  const BillingLandingPageEvent() : super(kBillingLandingPageEvent);
}

const kBillingDetailsPageEvent = 'billing_details_screen_view';

class BillingDetailsPageEvent extends TfbAnalyticsEvent {
  const BillingDetailsPageEvent() : super(kBillingDetailsPageEvent);
}

const kMakeAPaymentModalEvent = 'make_a_payment_modal_view';

class MakeAPaymentModalEvent extends TfbAnalyticsEvent {
  const MakeAPaymentModalEvent() : super(kMakeAPaymentModalEvent);
}

const kEnrollInAutoPayEvent = 'enroll_in_auto_pay_screen_view';

class EnrollInAutoPayEvent extends TfbAnalyticsEvent {
  const EnrollInAutoPayEvent() : super(kEnrollInAutoPayEvent);
}

const kEnrollInAutoPayCancelModalEvent = 'enroll_in_auto_pay_cancel_modal_view';

class EnrollInAutoPayCancelModalEvent extends TfbAnalyticsEvent {
  const EnrollInAutoPayCancelModalEvent()
      : super(kEnrollInAutoPayCancelModalEvent);
}

const kEnrollInAutoPaySuccessEvent = 'enroll_in_auto_pay_success_screen_view';

class EnrollInAutoPaySuccessEvent extends TfbAnalyticsEvent {
  const EnrollInAutoPaySuccessEvent() : super(kEnrollInAutoPaySuccessEvent);
}

const kManageAutoPayEvent = 'manage_auto_pay_screen_view';

class ManageAutoPayEvent extends TfbAnalyticsEvent {
  const ManageAutoPayEvent() : super(kManageAutoPayEvent);
}

const kUpdateAutoPayCancelModalEvent = 'update_auto_pay_cancel_modal_view';

class UpdateAutoPayCancelModalEvent extends TfbAnalyticsEvent {
  const UpdateAutoPayCancelModalEvent() : super(kUpdateAutoPayCancelModalEvent);
}

const kDiscontinueAutoPayScreenViewEvent = 'discontinue_auto_pay_screen_view';

class DiscontinueAutoPayScreenViewEvent extends TfbAnalyticsEvent {
  const DiscontinueAutoPayScreenViewEvent()
      : super(kDiscontinueAutoPayScreenViewEvent);
}
