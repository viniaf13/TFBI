// coverage:ignore-file

import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/data/network/clients/tfb_client.dart';
import 'package:txfb_insurance_flutter/data/network/constants/member_access_end_points.dart';
import 'package:txfb_insurance_flutter/domain/models/app_update/app_update_response.dart';
import 'package:txfb_insurance_flutter/domain/models/email_verification/email_verification_response.dart';
import 'package:txfb_insurance_flutter/domain/models/forgot_password/forgot_password_verify_request.dart';
import 'package:txfb_insurance_flutter/domain/models/forgot_password/forgot_password_verify_response.dart';
import 'package:txfb_insurance_flutter/domain/models/forgot_password/update_member_secure_password_request.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/delete_account_request.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/secure_registration_request.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/secure_registration_response.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/update_email_request.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/user_information.dart';
import 'package:txfb_insurance_flutter/domain/models/registration/registration_resend_request.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_generic_api_response.dart';

part 'tfb_member_access_client.g.dart';

/// Client for all end-points under the member access path
/// https://web.txfb-ins.com/services/tfbic.services.restmember.access/rest_memberaccess.svc/help

@RestApi(baseUrl: kStageApiBaseUrl)
abstract class TfbMemberAccessClient extends TfbClient {
  factory TfbMemberAccessClient({
    required String baseUrl,
    required Dio dio,
  }) =>
      _TfbMemberAccessClient(
        dio,
        baseUrl: baseUrl,
      );

  @POST('$kMemberAccessPath/$kSecureRegistration')
  Future<RegistrationResponse> secureRegistration(
    @Body() RegistrationRequest registrationRequest,
  );

  @GET('$kMemberAccessPath/$kUpdateMultiEmailVerification')
  Future<EmailVerificationResponse> updateMultipleEmailVerification(
    @Path() String validationCode,
  );

  @POST('$kMemberAccessPath/$kForgotPasswordVerify')
  Future<ForgotPasswordVerifyResponse> verifyForgotPasswordEmail(
    @Body() ForgotPasswordVerifyRequest request,
  );

  @POST('$kMemberAccessPath/$kUpdateMemberSecurePassword')
  Future<TfbGenericApiResponse> updateMemberSecurePassword(
    @Body() UpdateMemberSecurePasswordRequest request,
  );

  @POST(kRegisterResentEndpoint)
  Future<TfbGenericApiResponse> registerResend(
    @Body() RegistrationResendRequest registrationResendRequest,
  );

  @GET(kForgotPasswordEndpoint)
  Future<TfbGenericApiResponse> forgotPassword(@Path() String email);

  @POST(kDeleteAccountEndpoint)
  Future<TfbGenericApiResponse> deleteAccount(
    @Body() DeleteAccountRequest deleteRequest,
  );

  @GET(kFetchLogin)
  Future<List<UserInformation>> fetchMemberLogin(
    @Path() String memberNumber,
  );

  @POST(kUpdateEmailEndpoint)
  Future<TfbGenericApiResponse> updateEmail(
    @Body() UpdateEmailRequest updateRequest,
  );

  @GET('$kMemberAccessPath/$kMobileVersion')
  Future<AppUpdateResponse> checkAppVersion();
}
