import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/registration_resend/registration_resend_cubit.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/registration/registration_resend_request.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_generic_api_response.dart';

import '../../../mocks/mock_member_access_client.dart';

void main() {
  late TfbMemberAccessClient memberAccessClient;

  setUp(() {
    memberAccessClient = MockMemberAccessClient();

    registerFallbackValue(
      RegistrationResendRequest(
        communicationOption: 'communicationOption',
        emailAddress: 'emailAddress',
        memberNumber: 'memberNumber',
        password: 'password',
        policyNumber: 'policyNumber',
      ),
    );
  });

  test(
      'Registration resend cubit should start in the RegistrationResendInitial state',
      () {
    final cubit = RegistrationResendCubit(memberAccessClient);

    expect(cubit.state, isA<RegistrationResendInitial>());
  });

  blocTest<RegistrationResendCubit, RegistrationResendState>(
    'Registration resend cubit should move to processing state and success state if registration resend request is successful',
    build: () => RegistrationResendCubit(memberAccessClient),
    setUp: () {
      when(() => memberAccessClient.registerResend(any())).thenAnswer(
        (invocation) => Future.value(
          TfbGenericApiResponse(
            errorMessage: '',
            returnMessage: '',
          ),
        ),
      );
    },
    act: (bloc) => bloc.resendRegistration(
      RegistrationResendRequest(
        communicationOption: 'communicationOption',
        emailAddress: 'emailAddress',
        memberNumber: 'memberNumber',
        password: 'password',
        policyNumber: 'policyNumber',
      ),
    ),
    expect: () =>
        [isA<RegistrationResendProcessing>(), isA<RegistrationResendSuccess>()],
  );

  blocTest<RegistrationResendCubit, RegistrationResendState>(
    'Registration resend cubit should move to processing state and error state if registration resend request is successful but there is an error message in the response',
    build: () => RegistrationResendCubit(memberAccessClient),
    setUp: () {
      when(() => memberAccessClient.registerResend(any())).thenAnswer(
        (invocation) => Future.value(
          TfbGenericApiResponse(
            errorMessage: 'ERROR_MESSAGE',
            returnMessage: '',
          ),
        ),
      );
    },
    act: (bloc) => bloc.resendRegistration(
      RegistrationResendRequest(
        communicationOption: 'communicationOption',
        emailAddress: 'emailAddress',
        memberNumber: 'memberNumber',
        password: 'password',
        policyNumber: 'policyNumber',
      ),
    ),
    expect: () =>
        [isA<RegistrationResendProcessing>(), isA<RegistrationResendError>()],
  );

  blocTest<RegistrationResendCubit, RegistrationResendState>(
    'Registration resend cubit emits processing and error state if registration resend request fails',
    build: () => RegistrationResendCubit(memberAccessClient),
    setUp: () {
      when(() => memberAccessClient.registerResend(any())).thenAnswer(
        (invocation) => Future.error(Exception('Error')),
      );
    },
    act: (bloc) => bloc.resendRegistration(
      RegistrationResendRequest(
        communicationOption: 'communicationOption',
        emailAddress: 'emailAddress',
        memberNumber: 'memberNumber',
        password: 'password',
        policyNumber: 'policyNumber',
      ),
    ),
    expect: () =>
        [isA<RegistrationResendProcessing>(), isA<RegistrationResendError>()],
  );
}
