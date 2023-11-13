import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';

const kAppInformationEvent = 'app_information_screen_view';

class AppInformationEvent extends TfbAnalyticsEvent {
  const AppInformationEvent() : super(kAppInformationEvent);
}

const kMyAccountScreenView = 'my_account_screen_view';

class MyAccountScreenViewEvent extends TfbAnalyticsEvent {
  const MyAccountScreenViewEvent() : super(kMyAccountScreenView);
}

const kVerifyEmailScreenView = 'verify_email_screen_view';

class VerifyEmailScreenViewEvent extends TfbAnalyticsEvent {
  const VerifyEmailScreenViewEvent() : super(kVerifyEmailScreenView);
}

const kEditEmailSuccessScreenView = 'edit_email_success_screen_view';

class EditEmailSuccessScreenViewEvent extends TfbAnalyticsEvent {
  const EditEmailSuccessScreenViewEvent() : super(kEditEmailSuccessScreenView);
}

const kEditEmailFailureScreenView = 'edit_email_failure_screen_view';

class EditEmailFailureScreenViewEvent extends TfbAnalyticsEvent {
  const EditEmailFailureScreenViewEvent() : super(kEditEmailFailureScreenView);
}

const kChangePasswordScreenView = 'change_password_screen_view';

class ChangePasswordScreenViewEvent extends TfbAnalyticsEvent {
  const ChangePasswordScreenViewEvent() : super(kChangePasswordScreenView);
}

const kChangePasswordSuccessScreenView = 'change_password_success_screen_view';

class ChangePasswordSuccessScreenViewEvent extends TfbAnalyticsEvent {
  const ChangePasswordSuccessScreenViewEvent()
      : super(kChangePasswordSuccessScreenView);
}

const kLogOutModalView = 'log_out_modal_view';

class LogOutModalViewEvent extends TfbAnalyticsEvent {
  const LogOutModalViewEvent() : super(kLogOutModalView);
}

const kDeleteAccountModalView = 'delete_account_modal_view';

class DeleteAccountModalView extends TfbAnalyticsEvent {
  const DeleteAccountModalView() : super(kDeleteAccountModalView);
}
