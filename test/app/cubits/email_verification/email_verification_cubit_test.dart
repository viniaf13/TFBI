import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/email_verification/email_verification_cubit.dart';
import 'package:txfb_insurance_flutter/domain/models/email_verification/email_verification_response.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_registration_repository.dart';

import '../../../mocks/repository/mock_tfb_registration_repository.dart';

void main() {
  late TfbMemberRegistrationRepository mockRegistrationRepository;

  setUp(() {
    mockRegistrationRepository = MockTfbRegistrationRepository();
    resetMocktailState();
  });

  testWidgets(
      'Email verification cubit should start in the [EmailVerificationInitial] state',
      (tester) async {
    final cubit = EmailVerificationCubit(
      memberRegistrationRepository: mockRegistrationRepository,
    );

    expect(cubit.state, isA<EmailVerificationInitial>());
  });

  blocTest<EmailVerificationCubit, EmailVerificationState>(
    'If verifyEmail is called and the memberRegistrationRepository.verifyEmail call fails, move to [EmailVerificationError] state',
    setUp: () {
      when(() => mockRegistrationRepository.verifyEmail(any()))
          .thenThrow(Exception('ERROR'));
    },
    build: () => EmailVerificationCubit(
      memberRegistrationRepository: mockRegistrationRepository,
    ),
    act: (bloc) => bloc.verifyEmail('VALIDATION_CODE'),
    expect: () =>
        [isA<EmailVerificationProcessing>(), isA<EmailVerificationError>()],
  );

  blocTest<EmailVerificationCubit, EmailVerificationState>(
    'If verifyEmail is called and the memberRegistrationRepository.verifyEmail call is successful but returns an error message, move to [EmailVerificationError] state with message',
    setUp: () {
      when(() => mockRegistrationRepository.verifyEmail(any())).thenAnswer(
        (invocation) => Future.value(
          EmailVerificationResponse(
            errorMessage: 'ERROR',
            emailUpdate: '',
            returnMessage: '',
            verified: '',
          ),
        ),
      );
    },
    build: () => EmailVerificationCubit(
      memberRegistrationRepository: mockRegistrationRepository,
    ),
    act: (bloc) => bloc.verifyEmail('VALIDATION_CODE'),
    expect: () =>
        [isA<EmailVerificationProcessing>(), isA<EmailVerificationError>()],
    verify: (bloc) {
      final state = bloc.state;
      expect(state, isA<EmailVerificationError>());
      if (state is EmailVerificationError) {
        expect(state.error.message, 'ERROR');
      }
    },
  );

  blocTest<EmailVerificationCubit, EmailVerificationState>(
    'If verifyEmail is called and the memberRegistrationRepository.verifyEmail call is successful without an error message, move to the [EmailVerificationSuccess] state',
    setUp: () {
      when(() => mockRegistrationRepository.verifyEmail(any())).thenAnswer(
        (invocation) => Future.value(
          EmailVerificationResponse(
            errorMessage: '',
            emailUpdate: '',
            returnMessage: 'SUCCESS',
            verified: 'True',
          ),
        ),
      );
    },
    build: () => EmailVerificationCubit(
      memberRegistrationRepository: mockRegistrationRepository,
    ),
    act: (bloc) => bloc.verifyEmail('VALIDATION_CODE'),
    expect: () =>
        [isA<EmailVerificationProcessing>(), isA<EmailVerificationSuccess>()],
  );
}
