import 'package:test/test.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_router_query_params.dart';
import 'package:txfb_insurance_flutter/domain/models/registration/registration_resend_request.dart';

void main() {
  group('TfbRouterQueryParams', () {
    test('converts RegistrationResendRequest to query parameters', () {
      final request = RegistrationResendRequest(
        emailAddress: 'test@example.com',
        communicationOption: 'option1',
        memberNumber: '12345',
        password: 'password',
        policyNumber: 'policyNumber1',
      );

      final queryParams = TfbRouterQueryParams.fromRegistrationRequest(request);

      expect(
        queryParams[TfbRouterQueryParams.emailQueryKey],
        'test@example.com',
      );
      expect(
        queryParams[TfbRouterQueryParams.communicationQueryKey],
        'option1',
      );
      expect(queryParams[TfbRouterQueryParams.memberNumberKey], '12345');
      expect(queryParams[TfbRouterQueryParams.passwordKey], 'password');
      expect(
        queryParams[TfbRouterQueryParams.policyNumberKey],
        'policyNumber1',
      );
    });
  });
}
