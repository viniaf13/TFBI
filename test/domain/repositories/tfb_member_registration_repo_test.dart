import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/domain/models/email_verification/email_verification_response.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/secure_registration_request.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/secure_registration_response.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_registration_repository.dart';

import '../../mocks/mock_member_access_client.dart';

void main() {
  final mockMemberAccessClient = MockMemberAccessClient();

  setUp(() {
    registerFallbackValue(
      RegistrationRequest(
        communicationOption: '',
        emailAddress: '',
        memberNumber: '',
        password: '',
        policyNumber: '',
      ),
    );

    when(() => mockMemberAccessClient.secureRegistration(any())).thenAnswer(
      (invocation) => Future.value(
        RegistrationResponse(),
      ),
    );

    when(() => mockMemberAccessClient.updateMultipleEmailVerification(any()))
        .thenAnswer(
      (invocation) => Future.value(
        EmailVerificationResponse(
          verified: '',
          emailUpdate: '',
          errorMessage: '',
          returnMessage: '',
        ),
      ),
    );
  });

  test(
      'When a user is registered, then a RegistrationResponse should be returned',
      () {
    final repo =
        TfbMemberRegistrationRepository(networkClient: mockMemberAccessClient);

    final response = repo.registerUser(
      RegistrationRequest(
        communicationOption: '',
        emailAddress: '',
        memberNumber: '',
        password: '',
        policyNumber: '',
      ),
    );

    expect(response, isA<Future<RegistrationResponse>>());
  });

  test(
      'When an email is verified, then an EmailVerificationResponse should be returned',
      () {
    final repo =
        TfbMemberRegistrationRepository(networkClient: mockMemberAccessClient);
    final response = repo.verifyEmail('test_code');
    expect(response, isA<Future<EmailVerificationResponse>>());
  });
}
