import 'package:txfb_insurance_flutter/domain/models/registration/registration_resend_request.dart';

class TfbRouterQueryParams {
  /// Email validation page
  static const emailQueryKey = 'email';
  static const communicationQueryKey = 'communicationOption';
  static const memberNumberKey = 'memberNumber';
  static const passwordKey = 'password';
  static const policyNumberKey = 'policyNumber';
  static const loginPageSkipSplashAnimation = 'loginPageSkipSplashAnimation';
  static const isLoggingOut = 'isLoggingOut';
  static const location = 'location';

  static Map<String, dynamic> fromRegistrationRequest(
    RegistrationResendRequest request,
  ) {
    return {
      TfbRouterQueryParams.emailQueryKey: request.emailAddress,
      TfbRouterQueryParams.communicationQueryKey: request.communicationOption,
      TfbRouterQueryParams.memberNumberKey: request.memberNumber,
      TfbRouterQueryParams.passwordKey: request.password,
      TfbRouterQueryParams.policyNumberKey: request.policyNumber,
    };
  }
}
