import 'package:txfb_insurance_flutter/app/analytics/events/tfb_analytics_event.dart';

const kAccountRegistrationScreenView = 'account_registration_screen_view';

class AccountRegistrationScreenViewEvent extends TfbAnalyticsEvent {
  const AccountRegistrationScreenViewEvent()
      : super(kAccountRegistrationScreenView);
}

const kRegistrationVerifyEmailScreenView =
    'registration_verify_email_screen_view';

class RegistrationVerifyEmailScreenViewEvent extends TfbAnalyticsEvent {
  const RegistrationVerifyEmailScreenViewEvent()
      : super(kRegistrationVerifyEmailScreenView);
}

const kRegistrationFailureScreenView = 'registration_failure_screen_view';

class RegistrationFailureScreenViewEvent extends TfbAnalyticsEvent {
  const RegistrationFailureScreenViewEvent()
      : super(kRegistrationFailureScreenView);
}

const kRegistrationSuccessScreenView = 'registration_success_screen_view';

class RegistrationSuccessScreenViewEvent extends TfbAnalyticsEvent {
  const RegistrationSuccessScreenViewEvent()
      : super(kRegistrationSuccessScreenView);
}

const kMembershipCardModalView = 'membership_card_modal_view';

class MembershipCardModalViewEvent extends TfbAnalyticsEvent {
  const MembershipCardModalViewEvent() : super(kMembershipCardModalView);
}

const kForgetPasswordScreenView = 'forget_password_screen_view';

class ForgetPasswordScreenViewEvent extends TfbAnalyticsEvent {
  const ForgetPasswordScreenViewEvent() : super(kForgetPasswordScreenView);
}

const kAccountVerifiedScreenView = 'account_verified_screen_view';

class AccountVerifiedScreenViewEvent extends TfbAnalyticsEvent {
  const AccountVerifiedScreenViewEvent() : super(kAccountVerifiedScreenView);
}

const kUpdatePasswordSuccessScreenView = 'update_password_success_screen_view';

class UpdatePasswordSuccessScreenViewEvent extends TfbAnalyticsEvent {
  const UpdatePasswordSuccessScreenViewEvent()
      : super(kUpdatePasswordSuccessScreenView);
}
