import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/email_verification/email_verification_response.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/secure_registration_request.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/secure_registration_response.dart';

class TfbMemberRegistrationRepository {
  TfbMemberRegistrationRepository({required this.networkClient});

  factory TfbMemberRegistrationRepository.fromBaseUrl(
    String baseUrl,
    Dio dio,
  ) =>
      TfbMemberRegistrationRepository(
        networkClient: TfbMemberAccessClient(baseUrl: baseUrl, dio: dio),
      );

  TfbMemberAccessClient networkClient;

  Future<RegistrationResponse> registerUser(
    RegistrationRequest request,
  ) async =>
      networkClient.secureRegistration(request);

  Future<EmailVerificationResponse> verifyEmail(
    String validationCode,
  ) async =>
      networkClient.updateMultipleEmailVerification(validationCode);
}
