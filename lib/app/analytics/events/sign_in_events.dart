import 'package:txfb_insurance_flutter/app/analytics/events/tfb_analytics_event.dart';

const kSignInEvent = 'sign_in';
const kBiometricsLabel = 'Biometrics';
const kPasswordLabel = 'Password';

class SignInEvent extends TfbAnalyticsEvent {
  SignInEvent({required bool usedBiometrics, required String memberNumber})
      : super(
          kSignInEvent,
          properties: {
            'authentication_method':
                usedBiometrics ? kBiometricsLabel : kPasswordLabel,
            'member_number': memberNumber,
            'cta': 'Sign in',
          },
        );
}

const kEnableFaceIdModalView = 'enable_face_id_modal_view';

class EnableFaceIdModalView extends TfbAnalyticsEvent {
  const EnableFaceIdModalView() : super(kEnableFaceIdModalView);
}
