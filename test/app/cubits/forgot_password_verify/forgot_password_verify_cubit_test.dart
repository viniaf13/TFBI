import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/forgot_password_verify/forgot_password_verify_cubit.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/forgot_password/forgot_password_verify_request.dart';
import 'package:txfb_insurance_flutter/domain/models/forgot_password/forgot_password_verify_response.dart';
import 'package:txfb_insurance_flutter/domain/models/forgot_password/update_member_secure_password_request.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_generic_api_response.dart';

import '../../../mocks/mock_member_access_client.dart';

void main() {
  late TfbMemberAccessClient mockMemberAccessClient;

  setUp(() {
    resetMocktailState();
    mockMemberAccessClient = MockMemberAccessClient();
  });

  test('Forgot password verify cubit starts in the initial state', () {
    expect(
      ForgotPasswordVerifyCubit(memberAccessClient: mockMemberAccessClient)
          .state,
      isA<ForgotPasswordVerifyInitial>(),
    );
  });

  blocTest<ForgotPasswordVerifyCubit, ForgotPasswordVerifyState>(
    'If the [verifyForgotPasswordEmail] call on the member access client fails in the [submitUpdatedPassword], then the bloc should emit a failure state',
    setUp: () {
      registerFallbackValue(
        ForgotPasswordVerifyRequest(
          emailAddress: '',
          verificationCode: '',
        ),
      );

      when(() => mockMemberAccessClient.verifyForgotPasswordEmail(any()))
          .thenThrow(Exception('FAILURE'));
    },
    build: () =>
        ForgotPasswordVerifyCubit(memberAccessClient: mockMemberAccessClient),
    act: (bloc) => bloc.submitUpdatedPassword(
      UpdatedPasswordSubmission(
        emailAddress: 'emailAddress',
        verificationCode: 'verificationCode',
        password: 'password',
      ),
    ),
    expect: () => [
      isA<ForgotPasswordVerifyProcessing>(),
      isA<ForgotPasswordVerifyFailure>(),
    ],
  );

  blocTest<ForgotPasswordVerifyCubit, ForgotPasswordVerifyState>(
    'If the [verifyForgotPasswordEmail] call on the member access client succeeds in the [submitUpdatedPassword] but returns an error message, then the bloc should emit a failure state',
    setUp: () {
      registerFallbackValue(
        ForgotPasswordVerifyRequest(
          emailAddress: '',
          verificationCode: '',
        ),
      );

      when(() => mockMemberAccessClient.verifyForgotPasswordEmail(any()))
          .thenAnswer(
        (invocation) => Future.value(
          ForgotPasswordVerifyResponse(
            errorMessage: 'ERROR_MESSAGE',
            membershipArray: [],
            returnMessage: '',
          ),
        ),
      );
    },
    build: () =>
        ForgotPasswordVerifyCubit(memberAccessClient: mockMemberAccessClient),
    act: (bloc) => bloc.submitUpdatedPassword(
      UpdatedPasswordSubmission(
        emailAddress: 'emailAddress',
        verificationCode: 'verificationCode',
        password: 'password',
      ),
    ),
    expect: () => [
      isA<ForgotPasswordVerifyProcessing>(),
      isA<ForgotPasswordVerifyFailure>(),
    ],
  );

  blocTest<ForgotPasswordVerifyCubit, ForgotPasswordVerifyState>(
    'If the [verifyForgotPasswordEmail] call on the member access client succeeds in the [submitUpdatedPassword] but then the [updateMemberSecurePassword] call fails, then the bloc should emit a failure state',
    setUp: () {
      registerFallbackValue(
        ForgotPasswordVerifyRequest(
          emailAddress: '',
          verificationCode: '',
        ),
      );

      registerFallbackValue(
        UpdateMemberSecurePasswordRequest(
          memberId: 0,
          membershipArray: [],
          newPassword: '',
          userName: '',
        ),
      );

      when(() => mockMemberAccessClient.verifyForgotPasswordEmail(any()))
          .thenAnswer(
        (invocation) => Future.value(
          ForgotPasswordVerifyResponse(
            errorMessage: '',
            membershipArray: [],
            returnMessage: '',
          ),
        ),
      );

      when(() => mockMemberAccessClient.updateMemberSecurePassword(any()))
          .thenThrow(Exception('ERROR'));
    },
    build: () =>
        ForgotPasswordVerifyCubit(memberAccessClient: mockMemberAccessClient),
    act: (bloc) => bloc.submitUpdatedPassword(
      UpdatedPasswordSubmission(
        emailAddress: 'emailAddress',
        verificationCode: 'verificationCode',
        password: 'password',
      ),
    ),
    expect: () => [
      isA<ForgotPasswordVerifyProcessing>(),
      isA<ForgotPasswordVerifyFailure>(),
    ],
  );

  blocTest<ForgotPasswordVerifyCubit, ForgotPasswordVerifyState>(
    'If the [verifyForgotPasswordEmail] call on the member access client succeeds in the [submitUpdatedPassword] and then the [updateMemberSecurePassword] call succeeds with an error message, then the bloc should emit a failure state',
    setUp: () {
      registerFallbackValue(
        ForgotPasswordVerifyRequest(
          emailAddress: '',
          verificationCode: '',
        ),
      );

      registerFallbackValue(
        UpdateMemberSecurePasswordRequest(
          memberId: 0,
          membershipArray: [],
          newPassword: '',
          userName: '',
        ),
      );

      when(() => mockMemberAccessClient.verifyForgotPasswordEmail(any()))
          .thenAnswer(
        (invocation) => Future.value(
          ForgotPasswordVerifyResponse(
            errorMessage: '',
            membershipArray: [],
            returnMessage: '',
          ),
        ),
      );

      when(() => mockMemberAccessClient.updateMemberSecurePassword(any()))
          .thenAnswer(
        (invocation) => Future.value(
          TfbGenericApiResponse(
            errorMessage: 'ERROR_MESSAGE',
            returnMessage: '',
          ),
        ),
      );
    },
    build: () =>
        ForgotPasswordVerifyCubit(memberAccessClient: mockMemberAccessClient),
    act: (bloc) => bloc.submitUpdatedPassword(
      UpdatedPasswordSubmission(
        emailAddress: 'emailAddress',
        verificationCode: 'verificationCode',
        password: 'password',
      ),
    ),
    expect: () => [
      isA<ForgotPasswordVerifyProcessing>(),
      isA<ForgotPasswordVerifyFailure>(),
    ],
  );

  blocTest<ForgotPasswordVerifyCubit, ForgotPasswordVerifyState>(
    'If [verifyForgotPasswordEmail] and [updateMemberSecurePassword] calls succeed in the [submitUpdatedPassword] event, then the cubit should emit a success state',
    setUp: () {
      registerFallbackValue(
        ForgotPasswordVerifyRequest(
          emailAddress: '',
          verificationCode: '',
        ),
      );

      registerFallbackValue(
        UpdateMemberSecurePasswordRequest(
          memberId: 0,
          membershipArray: [],
          newPassword: '',
          userName: '',
        ),
      );

      when(() => mockMemberAccessClient.verifyForgotPasswordEmail(any()))
          .thenAnswer(
        (invocation) => Future.value(
          ForgotPasswordVerifyResponse(
            errorMessage: '',
            membershipArray: [],
            returnMessage: '',
          ),
        ),
      );

      when(() => mockMemberAccessClient.updateMemberSecurePassword(any()))
          .thenAnswer(
        (invocation) => Future.value(
          TfbGenericApiResponse(errorMessage: '', returnMessage: ''),
        ),
      );
    },
    build: () =>
        ForgotPasswordVerifyCubit(memberAccessClient: mockMemberAccessClient),
    act: (bloc) => bloc.submitUpdatedPassword(
      UpdatedPasswordSubmission(
        emailAddress: 'emailAddress',
        verificationCode: 'verificationCode',
        password: 'password',
      ),
    ),
    expect: () => [
      isA<ForgotPasswordVerifyProcessing>(),
      isA<ForgotPasswordVerifySuccess>(),
    ],
  );
}
