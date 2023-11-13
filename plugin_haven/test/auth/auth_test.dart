import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:plugin_haven/test/mock/haven_mocks.dart';

import 'mock_saml.dart';

void main() {
  late MockAuthRepository mockAuth;
  setUp(() {
    mockAuth = MockAuthRepository();
  });
  tearDown(() {});
  group('Haven Auth Utils Tests', () {
    test('Generates valid PCKE code', () {
      const hashChars =
          'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      final pcke = mockAuth.createPkceCode();
      final verifier = pcke.verifier;
      expect(verifier.length, 43);
      final invalidChars =
          verifier.characters.takeWhile((c) => !hashChars.contains(c));
      expect(invalidChars.length, 0);
      final challenge =
          base64UrlEncode(sha256.convert(ascii.encode(verifier)).bytes)
              .replaceAll('=', '')
              .replaceAll('+', '-')
              .replaceAll('/', '_');
      expect(challenge, pcke.challenge);
    });
    test('SAML decode', () {
      final mockSaml = MockAuthResponse();
      final assertion = base64UrlEncode(utf8.encode(mockSaml.data));
      final data = mockAuth.decodeSamlAssertion(mockSaml.assertion);
      expect(data, mockSaml.data);
      expect('SAMLResponse=$assertion', mockSaml.assertion);
    });
    test('Decode ID token', () {
      final response = MockAuthResponse().token;
      final idMap = mockAuth.decodeIdToken(response['id_token']);
      expect(idMap['iss'], 'https://accounts.google.com');
    });

    group('AuthBloc tests', () {
      test('AuthBloc initial state', () {
        final bloc = AuthBloc(authenticator: mockAuth);
        expect(bloc.state, isA<AuthInitState>());
      });
      blocTest<AuthBloc, AuthState>(
        'AuthBloc initialization',
        build: () => AuthBloc(authenticator: mockAuth),
        expect: () => [isA<AuthProcessing>(), isA<AuthSignedOut>()],
        verify: (_) => expect(mockAuth.isInitialized, true),
      );
      blocTest(
        'AuthBloc logging and cancel',
        build: () => AuthBloc(authenticator: mockAuth),
        act: (bloc) {
          bloc.add(const AuthLogEvent('auth log message'));
          bloc.add(AuthCancelEvent());
        },
        skip: 2,
        expect: () => [
          const AuthProcessing(logMessage: 'auth log message'),
          isA<AuthSignedOut>(),
        ],
      );
      blocTest(
        'AuthBloc Signed In',
        build: () =>
            AuthBloc(authenticator: MockAuthRepository(user: MockUser())),
        expect: () => [isA<AuthProcessing>(), isA<AuthSignedIn>()],
      );
      blocTest(
        'AuthBloc cancel when signed in',
        build: () =>
            AuthBloc(authenticator: MockAuthRepository(user: MockUser())),
        act: (bloc) {
          bloc.add(AuthCancelEvent());
        },
        skip: 2,
        expect: () => [],
      );
      blocTest(
        'AuthBloc sign in / sign out flow',
        build: () => AuthBloc(authenticator: MockAuthRepository()),
        act: (bloc) {
          bloc.add(const AuthSignInEvent(properties: 'properties'));
          bloc.stream.listen((event) {
            if (event is AuthSignedIn) {
              bloc.add(AuthSignOutEvent());
            }
          });
        },
        skip: 2,
        expect: () => [
          const AuthProcessing(),
          AuthSignedIn(MockUser(), properties: 'properties'),
          const AuthProcessing(),
          AuthSignedOut(),
        ],
      );
      blocTest(
        'AuthBloc error handling',
        build: () => AuthBloc(authenticator: MockAuthRepository()),
        act: (bloc) {
          bloc.add(const AuthSignInEvent(properties: 'error'));
          bloc.stream.listen((event) {
            if (event is AuthError) {
              bloc.add(AuthCancelEvent());
            }
          });
        },
        skip: 2,
        expect: () => [
          const AuthProcessing(),
          isA<AuthError>(),
          AuthSignedOut(),
        ],
      );
      blocTest(
        'AuthBloc flow events',
        build: () => AuthBloc(authenticator: MockAuthRepository()),
        act: (bloc) {
          bloc.add(const AuthSignInEvent(properties: 'flow'));
          bloc.add(const AuthFlowEvent('response'));
        },
        skip: 2,
        expect: () => [
          const AuthProcessing(),
          const AuthProcessing(logMessage: 'response'),
        ],
      );
      blocTest(
        'AuthBloc update user',
        build: () =>
            AuthBloc(authenticator: MockAuthRepository(user: MockUser())),
        act: (bloc) {
          bloc.stream.listen((event) {
            bool added = false;
            if (!added && event is AuthSignedIn) {
              added = true;
              final updatedUser =
                  (bloc.authenticator.user as MockUser).copyWith(value: 7);
              bloc.add(AuthUpdateUserEvent(updatedUser));
            }
          });
        },
        verify: (bloc) =>
            bloc.state is AuthSignedIn &&
            bloc.authenticator.user == MockUser(value: 7),
      );
    });
  });
}
