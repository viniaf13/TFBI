import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/registration/registration_bloc.dart';
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/secure_registration_request.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/secure_registration_response.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_registration_repository.dart';

import '../../../mocks/mock_dio_error.dart';
import '../../../mocks/repository/mock_registration_repo.dart';

void main() {
  late TfbMemberRegistrationRepository mockRegistrationRepository;

  setUp(() {
    mockRegistrationRepository = MockRegistrationRepo();
    resetMocktailState();
    registerFallbackValue(
      RegistrationRequest(
        communicationOption: '',
        emailAddress: '',
        memberNumber: '',
        password: '',
        policyNumber: '',
      ),
    );
  });

  test(
    'Bloc starts in init state',
    () => expect(
      RegistrationBloc(repository: mockRegistrationRepository).state,
      const RegistrationInitState(),
    ),
  );

  blocTest<RegistrationBloc, RegistrationState>(
    'When client returns an error message from the server, then state should change from init to processing to failure with the server error message',
    setUp: () {
      when(() => mockRegistrationRepository.registerUser(any())).thenAnswer(
        (invocation) =>
            Future.value(RegistrationResponse(errorMessage: 'ERROR')),
      );
    },
    build: () => RegistrationBloc(repository: mockRegistrationRepository),
    act: (bloc) => bloc.add(
      RegistrationSubmitEvent(
        request: RegistrationRequest(
          communicationOption: '',
          emailAddress: '',
          memberNumber: '',
          password: '',
          policyNumber: '',
        ),
      ),
    ),
    expect: () =>
        [isA<RegistrationProcessingState>(), isA<RegistrationFailureState>()],
    verify: (bloc) {
      final state = bloc.state;
      expect(state, isA<RegistrationFailureState>());
      if (state is RegistrationFailureState) {
        expect(state.error.message, 'ERROR');
      }
    },
  );

  blocTest<RegistrationBloc, RegistrationState>(
    'When client returns a network error, then state should change from init to processing to failure with the network error message',
    setUp: () {
      when(() => mockRegistrationRepository.registerUser(any())).thenAnswer(
        (invocation) => Future.value(
          RegistrationResponse(errorMessage: MockDioError.defaultMessage),
        ),
      );
    },
    build: () => RegistrationBloc(repository: mockRegistrationRepository),
    act: (bloc) => bloc.add(
      RegistrationSubmitEvent(
        request: RegistrationRequest(
          communicationOption: '',
          emailAddress: '',
          memberNumber: '',
          password: '',
          policyNumber: '',
        ),
      ),
    ),
    expect: () =>
        [isA<RegistrationProcessingState>(), isA<RegistrationFailureState>()],
    verify: (bloc) {
      final state = bloc.state;
      expect(state, isA<RegistrationFailureState>());
      if (state is RegistrationFailureState) {
        expect(state.error.message, MockDioError.defaultMessage);
      }
    },
  );

  blocTest<RegistrationBloc, RegistrationState>(
    'When client returns an unknown erorr, then state should change from init to processing to failure with a generic error message',
    setUp: () {
      when(() => mockRegistrationRepository.registerUser(any()))
          .thenThrow(Exception('ERROR'));
    },
    build: () => RegistrationBloc(repository: mockRegistrationRepository),
    act: (bloc) => bloc.add(
      RegistrationSubmitEvent(
        request: RegistrationRequest(
          communicationOption: '',
          emailAddress: '',
          memberNumber: '',
          password: '',
          policyNumber: '',
        ),
      ),
    ),
    expect: () =>
        [isA<RegistrationProcessingState>(), isA<RegistrationFailureState>()],
    verify: (bloc) {
      final state = bloc.state;
      expect(state, isA<RegistrationFailureState>());
      if (state is RegistrationFailureState) {
        expect(state.error.message, tfbRequestErrorMessageDefault);
      }
    },
  );

  blocTest<RegistrationBloc, RegistrationState>(
    'When client returns a success, Then state should change from init to processing to success',
    setUp: () {
      when(() => mockRegistrationRepository.registerUser(any())).thenAnswer(
        (invocation) => Future.value(RegistrationResponse()),
      );
    },
    build: () => RegistrationBloc(repository: mockRegistrationRepository),
    act: (bloc) => bloc.add(
      RegistrationSubmitEvent(
        request: RegistrationRequest(
          communicationOption: '',
          emailAddress: '',
          memberNumber: '',
          password: '',
          policyNumber: '',
        ),
      ),
    ),
    expect: () =>
        [isA<RegistrationProcessingState>(), isA<RegistrationSuccessState>()],
  );
}
