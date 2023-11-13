import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';

const kClaimsLandingViewEvent = 'claims_landing_screen_view';
const kBeginClaimViewEvent = 'begin_claim_screen_view';
const kAutoClaimFormViewEvent = 'auto_claim_form_view';
const kPropertyClaimFormViewEvent = 'property_claim_form_view';
const kAddPhotosClaimFormViewEvent = 'add_photos_screen_view';
const kSubmitAutoClaimSucessViewEvent = 'submit_auto_claim_success_view';
const kSubmitPropertyClaimSucessViewEvent =
    'submit_property_claim_success_view';
const kCancelClaimModalViewEvent = 'cancel_claim_modal_view';

class ClaimsLandingViewEvent extends TfbAnalyticsEvent {
  const ClaimsLandingViewEvent() : super(kClaimsLandingViewEvent);
}

class BeginClaimViewEvent extends TfbAnalyticsEvent {
  const BeginClaimViewEvent() : super(kBeginClaimViewEvent);
}

class AutoClaimFormViewEvent extends TfbAnalyticsEvent {
  const AutoClaimFormViewEvent() : super(kAutoClaimFormViewEvent);
}

class PropertyClaimFormViewEvent extends TfbAnalyticsEvent {
  const PropertyClaimFormViewEvent() : super(kPropertyClaimFormViewEvent);
}

class AddPhotosClaimFormViewEvent extends TfbAnalyticsEvent {
  const AddPhotosClaimFormViewEvent() : super(kAddPhotosClaimFormViewEvent);
}

class SubmitAutoClaimSucessViewEvent extends TfbAnalyticsEvent {
  const SubmitAutoClaimSucessViewEvent()
      : super(kSubmitAutoClaimSucessViewEvent);
}

class SubmitPropertyClaimSucessViewEvent extends TfbAnalyticsEvent {
  const SubmitPropertyClaimSucessViewEvent()
      : super(kSubmitPropertyClaimSucessViewEvent);
}

class CancelClaimModalViewEvent extends TfbAnalyticsEvent {
  const CancelClaimModalViewEvent() : super(kCancelClaimModalViewEvent);
}
