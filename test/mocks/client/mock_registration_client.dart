import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/secure_registration_request.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/secure_registration_response.dart';

class MockRegistrationClient extends Mock implements TfbMemberAccessClient {
  @override
  Future<RegistrationResponse> secureRegistration(
    RegistrationRequest registrationRequest,
  ) async {
    return RegistrationResponse();
  }
}
