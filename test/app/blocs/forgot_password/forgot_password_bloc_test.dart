import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_authentication_client.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_generic_api_response.dart';

import '../../../mocks/mock_member_access_client.dart';

class MockForgotPasswordBloc
    extends MockBloc<ForgotPasswordEvent, ForgotPasswordState>
    implements ForgotPasswordBloc {}

class MockAuthClient extends Mock implements TfbAuthenticationClient {}

void main() {
  late TfbMemberAccessClient mockMemberAccessClient;

  setUp(() {
    mockMemberAccessClient = MockMemberAccessClient();
  });

  test('Forgot password bloc starts in the init state', () {
    expect(
      ForgotPasswordBloc(memberAccessClient: mockMemberAccessClient).state,
      ForgotPasswordInitial(),
    );
  });

  test('Two request events with the same email are equivalent', () {
    expect(
      const RequestForgotPasswordEvent('test@email.com').props,
      ['test@email.com'],
    );
  });

  blocTest<ForgotPasswordBloc, ForgotPasswordState>(
    'When the forgot password auth client returns a successful response, move from intitial state to success state',
    setUp: () {
      when(() => mockMemberAccessClient.forgotPassword(any())).thenAnswer(
        (invocation) => Future.value(
          TfbGenericApiResponse(
            errorMessage: '',
            returnMessage: '',
          ),
        ),
      );
    },
    build: () => ForgotPasswordBloc(memberAccessClient: mockMemberAccessClient),
    act: (bloc) => bloc.add(const RequestForgotPasswordEvent('test@email.com')),
    expect: () => [
      isA<ForgotPasswordRequestProcessing>(),
      isA<ForgotPasswordRequestSuccess>(),
    ],
  );

  blocTest<ForgotPasswordBloc, ForgotPasswordState>(
    'When the forgot password auth client returns an error future, move from initial state to error state',
    setUp: () {
      when(() => mockMemberAccessClient.forgotPassword(any())).thenThrow(
        Exception('ERROR'),
      );
    },
    build: () => ForgotPasswordBloc(memberAccessClient: mockMemberAccessClient),
    act: (bloc) => bloc.add(const RequestForgotPasswordEvent('test@email.com')),
    expect: () => [
      isA<ForgotPasswordRequestProcessing>(),
      isA<ForgotPasswordRequestError>(),
    ],
  );

  blocTest<ForgotPasswordBloc, ForgotPasswordState>(
    'When the forgot password auth client returns a successful response but an error message in the response, move from initial state to error state',
    setUp: () {
      when(() => mockMemberAccessClient.forgotPassword(any())).thenAnswer(
        (invocation) => Future.value(
          TfbGenericApiResponse(
            errorMessage: 'ERROR_MESSAGE!',
            returnMessage: '',
          ),
        ),
      );
    },
    build: () => ForgotPasswordBloc(memberAccessClient: mockMemberAccessClient),
    act: (bloc) => bloc.add(const RequestForgotPasswordEvent('test@email.com')),
    expect: () => [
      isA<ForgotPasswordRequestProcessing>(),
      isA<ForgotPasswordRequestError>(),
    ],
  );
}
