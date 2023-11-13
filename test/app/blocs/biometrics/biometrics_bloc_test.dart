import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/biometrics/biometrics_bloc.dart';
import 'package:txfb_insurance_flutter/device/biometrics/tfb_biometrics.dart';
import 'package:txfb_insurance_flutter/domain/models/login/tfb_user.dart';
import 'package:txfb_insurance_flutter/domain/repositories/storage/tfb_user_storage_repository.dart';

import '../../../mocks/mock_biometrics.dart';
import '../../../mocks/mock_tfb_user.dart';
import '../../../mocks/mock_tfb_user_storage_repository.dart';

void main() {
  late TfbBiometrics mockBiometrics;
  late TfbUserStorageRepository mockUserStorage;
  late TfbUser unexpiredUser;

  setUp(() {
    mockBiometrics = MockBiometrics();
    mockUserStorage = MockTfbUserStorageRepository();
    unexpiredUser = MockTfbUser();
  });

  testWidgets('Biometrics bloc starts in the initial state', (tester) async {
    when(mockBiometrics.isBiometricsEnabled).thenAnswer((_) async => true);
    expect(
      BiometricsBloc(
        biometrics: mockBiometrics,
        userStorageRepository: mockUserStorage,
      ).state,
      isA<BiometricsInitState>(),
    );
  });

  blocTest<BiometricsBloc, BiometricsState>(
    'If the users token is expired, the bloc should emit a [BiometricsFailed] state with the correct failure reason',
    setUp: () {
      resetMocktailState();
      final expiredUser = MockTfbUser();
      when(expiredUser.isTokenExpired).thenReturn(true);
      when(mockUserStorage.getUser)
          .thenAnswer((invocation) => Future.value(expiredUser));
      when(mockBiometrics.isBiometricsEnabled).thenAnswer((_) async => true);
    },
    build: () => BiometricsBloc(
      biometrics: mockBiometrics,
      userStorageRepository: mockUserStorage,
    ),
    act: (bloc) => bloc.add(const PromptBiometricsIfAvailable()),
    expect: () => [
      isA<BiometricsInitializingState>(),
      isA<BiometricsReadyState>(),
      isA<BiometricsProcessing>(),
      isA<BiometricsFailed>(),
    ],
    verify: (bloc) {
      final blocState = bloc.state;

      expect(
        blocState is BiometricsFailed &&
            blocState.error == BiometricsFailureReason.storedUserSessionExpired,
        isTrue,
      );
    },
  );

  blocTest<BiometricsBloc, BiometricsState>(
    'If no user is stored, the bloc should emit a [BiometricsFailed] state with the correct failure reason',
    setUp: () {
      resetMocktailState();
      when(mockUserStorage.getUser).thenAnswer((invocation) => Future.value());
      when(mockBiometrics.isBiometricsEnabled).thenAnswer((_) async => true);
    },
    build: () => BiometricsBloc(
      biometrics: mockBiometrics,
      userStorageRepository: mockUserStorage,
    ),
    act: (bloc) => bloc.add(const PromptBiometricsIfAvailable()),
    expect: () => [
      isA<BiometricsInitializingState>(),
      isA<BiometricsReadyState>(),
      isA<BiometricsProcessing>(),
      isA<BiometricsFailed>(),
    ],
    verify: (bloc) {
      final blocState = bloc.state;

      expect(
        blocState is BiometricsFailed &&
            blocState.error == BiometricsFailureReason.noStoredUser,
        isTrue,
      );
    },
  );

  blocTest<BiometricsBloc, BiometricsState>(
    'If an unknown error occurs while processing biometrics, the bloc should emit a [BiometricsFailed] state with the correct failure reason',
    setUp: () {
      when(mockUserStorage.getUser).thenThrow(Exception('UNKNOWN_ERROR'));
      when(mockBiometrics.isBiometricsEnabled).thenAnswer((_) async => true);
    },
    build: () => BiometricsBloc(
      biometrics: mockBiometrics,
      userStorageRepository: mockUserStorage,
    ),
    act: (bloc) => bloc.add(const PromptBiometricsIfAvailable()),
    expect: () => [
      isA<BiometricsInitializingState>(),
      isA<BiometricsReadyState>(),
      isA<BiometricsProcessing>(),
      isA<BiometricsFailed>(),
    ],
    verify: (bloc) {
      final blocState = bloc.state;

      expect(
        blocState is BiometricsFailed &&
            blocState.error == BiometricsFailureReason.unknown,
        isTrue,
      );
    },
  );

  blocTest<BiometricsBloc, BiometricsState>(
    'If biometrics are not enabled, the bloc should emit a [BiometricsFailed] state with the correct failure reason',
    setUp: () {
      resetMocktailState();
      when(unexpiredUser.isTokenExpired).thenReturn(false);
      when(mockUserStorage.getUser)
          .thenAnswer((invocation) => Future.value(unexpiredUser));
      when(mockBiometrics.isBiometricsEnabled)
          .thenAnswer((invocation) => Future.value(false));
    },
    build: () => BiometricsBloc(
      biometrics: mockBiometrics,
      userStorageRepository: mockUserStorage,
    ),
    act: (bloc) => bloc.add(const PromptBiometricsIfAvailable()),
    expect: () => [
      isA<BiometricsInitializingState>(),
      isA<BiometricsReadyState>(),
      isA<BiometricsProcessing>(),
      isA<BiometricsFailed>(),
    ],
    verify: (bloc) {
      final blocState = bloc.state;

      expect(
        blocState is BiometricsFailed &&
            blocState.error == BiometricsFailureReason.biometricsNotAvailable,
        isTrue,
      );
    },
  );

  blocTest<BiometricsBloc, BiometricsState>(
    'If biometrics authentication fails, the bloc should emit a [BiometricsFailed] state with the correct failure reason',
    setUp: () {
      resetMocktailState();
      when(unexpiredUser.isTokenExpired).thenReturn(false);
      when(mockUserStorage.getUser)
          .thenAnswer((invocation) => Future.value(unexpiredUser));
      when(mockBiometrics.isBiometricsEnabled)
          .thenAnswer((invocation) => Future.value(true));
      when(mockBiometrics.isAuthenticated)
          .thenAnswer((invocation) => Future.value(false));
    },
    build: () => BiometricsBloc(
      biometrics: mockBiometrics,
      userStorageRepository: mockUserStorage,
    ),
    act: (bloc) => bloc.add(const PromptBiometricsIfAvailable()),
    expect: () => [
      isA<BiometricsInitializingState>(),
      isA<BiometricsReadyState>(),
      isA<BiometricsProcessing>(),
      isA<BiometricsFailed>(),
    ],
    verify: (bloc) {
      final blocState = bloc.state;

      expect(
        blocState is BiometricsFailed &&
            blocState.error ==
                BiometricsFailureReason.biometricAuthenticatedFailed,
        isTrue,
      );
    },
  );

  blocTest<BiometricsBloc, BiometricsState>(
    'If the stored user is not expired, biometrics are enabled, and authentication succeeds, the bloc should emit a [BiometricsSucceeded] state with the correct user object',
    setUp: () {
      resetMocktailState();
      when(unexpiredUser.isTokenExpired).thenReturn(false);
      when(mockUserStorage.getUser)
          .thenAnswer((invocation) => Future.value(unexpiredUser));
      when(mockBiometrics.isBiometricsEnabled)
          .thenAnswer((invocation) => Future.value(true));
      when(mockBiometrics.isAuthenticated)
          .thenAnswer((invocation) => Future.value(true));
    },
    build: () => BiometricsBloc(
      biometrics: mockBiometrics,
      userStorageRepository: mockUserStorage,
    ),
    act: (bloc) => bloc.add(const PromptBiometricsIfAvailable()),
    expect: () => [
      isA<BiometricsInitializingState>(),
      isA<BiometricsReadyState>(),
      isA<BiometricsProcessing>(),
      isA<BiometricsSucceeded>(),
    ],
    verify: (bloc) {
      final blocState = bloc.state;

      expect(
        blocState is BiometricsSucceeded && blocState.user == unexpiredUser,
        isTrue,
      );
    },
  );
}
