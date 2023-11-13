import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retrofit/retrofit.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_authentication_client.dart';
import 'package:txfb_insurance_flutter/domain/models/login/login.dart';
import 'package:txfb_insurance_flutter/domain/repositories/storage/tfb_user_storage_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_auth_repository.dart';

import '../../mocks/mock_tfb_auth_client.dart';
import '../../mocks/mock_tfb_user_storage_repository.dart';

void main() {
  late TfbAuthenticationClient mockAuthClient;
  late TfbUserStorageRepository<TfbUser> mockUserStorageRepository;

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    registerFallbackValue(
      LoginRequest(password: '', username: ''),
    );

    mockAuthClient = MockTfbAuthClient();
    mockUserStorageRepository = MockTfbUserStorageRepository();
  });

  test('The auth repository should always start in a signed out state',
      () async {
    when(() => mockUserStorageRepository.getUser())
        .thenAnswer((_) => Future.value());

    final authRepo = TfbAuthRepository(
      authClient: mockAuthClient,
      userStorageRepository: mockUserStorageRepository,
    );

    await authRepo.init();
    expect(authRepo.isSignedIn, false);
  });

  test(
      'If the user logs in and there is an error message on the login response, the user should not be signed in',
      () async {
    when(() => mockAuthClient.login(any())).thenAnswer((invocation) async {
      return HttpResponse(
        LoginResponse(errorMessage: 'ERROR!'),
        Response(requestOptions: RequestOptions()),
      );
    });

    when(() => mockUserStorageRepository.getUser())
        .thenAnswer((_) => Future.value());

    final authRepo = TfbAuthRepository(
      authClient: mockAuthClient,
      userStorageRepository: mockUserStorageRepository,
    );

    await authRepo.init();
    await authRepo.signIn(
      credentials: LoginRequest(password: '', username: ''),
    );

    expect(authRepo.isSignedIn, false);
    expect(authRepo.user, null);
  });

  test(
      'If something other than a login request is passed to the login call, the user should not be signed in',
      () async {
    when(() => mockAuthClient.login(any())).thenAnswer((invocation) async {
      return HttpResponse(
        LoginResponse(accessToken: 'ACCESS_TOKEN'),
        Response(requestOptions: RequestOptions()),
      );
    });

    when(() => mockUserStorageRepository.getUser())
        .thenAnswer((_) => Future.value());

    final authRepo = TfbAuthRepository(
      authClient: mockAuthClient,
      userStorageRepository: mockUserStorageRepository,
    );

    await authRepo.init();
    await authRepo.signIn(
      credentials: Object(),
    );

    expect(authRepo.isSignedIn, false);
    expect(authRepo.user, null);
  });

  test(
      'If the user logs in and there is not an error message on the login response, the user should be signed in',
      () async {
    when(() => mockAuthClient.login(any())).thenAnswer((invocation) async {
      return HttpResponse(
        LoginResponse(accessToken: 'MY_ACCESS_TOKEN'),
        Response(requestOptions: RequestOptions()),
      );
    });

    when(() => mockUserStorageRepository.getUser())
        .thenAnswer((_) => Future.value());

    final authRepo = TfbAuthRepository(
      authClient: mockAuthClient,
      userStorageRepository: mockUserStorageRepository,
    );

    await authRepo.init();
    await authRepo.signIn(
      credentials: LoginRequest(password: '', username: ''),
    );

    expect(authRepo.isSignedIn, true);
  });

  test(
      'If the user logs in and then logs back out, they should not be signed in',
      () async {
    when(() => mockAuthClient.login(any())).thenAnswer((invocation) async {
      return HttpResponse(
        LoginResponse(accessToken: 'MY_ACCESS_TOKEN'),
        Response(requestOptions: RequestOptions()),
      );
    });

    when(() => mockUserStorageRepository.getUser())
        .thenAnswer((_) => Future.value());

    when(() => mockUserStorageRepository.clearUser())
        .thenAnswer((invocation) => Future.value());

    final repo = TfbAuthRepository(
      authClient: mockAuthClient,
      userStorageRepository: mockUserStorageRepository,
    );

    await repo.init();
    await repo.signIn(
      credentials: LoginRequest(password: '', username: ''),
    );
    await repo.signOut();

    expect(repo.isSignedIn, false);
  });

  test('When signing in, the isAuthenticating flag should be set to true',
      () async {
    when(() => mockAuthClient.login(any())).thenAnswer((invocation) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      return HttpResponse(
        LoginResponse(accessToken: 'MY_ACCESS_TOKEN'),
        Response(requestOptions: RequestOptions()),
      );
    });

    when(() => mockUserStorageRepository.getUser())
        .thenAnswer((_) => Future.value());

    final repo = TfbAuthRepository(
      authClient: mockAuthClient,
      userStorageRepository: mockUserStorageRepository,
    );

    await repo.init();
    repo.signIn(
      credentials: LoginRequest(password: '', username: ''),
    );

    expect(repo.isAuthenticating, true);
  });

  test('When signing in, cancelling a sign in request should not set the user',
      () async {
    when(() => mockAuthClient.login(any())).thenAnswer((invocation) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      return HttpResponse(
        LoginResponse(accessToken: 'MY_ACCESS_TOKEN'),
        Response(requestOptions: RequestOptions()),
      );
    });

    when(() => mockUserStorageRepository.getUser())
        .thenAnswer((_) => Future.value());

    final authRepo = TfbAuthRepository(
      authClient: mockAuthClient,
      userStorageRepository: mockUserStorageRepository,
    );

    await authRepo.init();
    authRepo.signIn(
      credentials: LoginRequest(password: '', username: ''),
    );

    await Future<void>.delayed(const Duration(milliseconds: 500));
    authRepo.cancel();
    await Future<void>.delayed(const Duration(milliseconds: 700));

    expect(authRepo.isAuthenticating, false);
    expect(authRepo.user, null);
  });
}
