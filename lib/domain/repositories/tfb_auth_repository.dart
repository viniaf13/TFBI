import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_authentication_client.dart';
import 'package:txfb_insurance_flutter/domain/exceptions/login_exception.dart';
import 'package:txfb_insurance_flutter/domain/models/login/login_request.dart';
import 'package:txfb_insurance_flutter/domain/models/login/tfb_user.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/storage/tfb_user_storage_repository.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class TfbAuthRepository extends AuthRepository<TfbUser> {
  TfbAuthRepository({
    required this.authClient,
    required this.userStorageRepository,
  });

  TfbAuthenticationClient authClient;
  TfbUserStorageRepository<TfbUser> userStorageRepository;
  TfbUser? _user;
  bool _isAuthenticating = false;
  bool _isCancelled = false;
  String? _logMessage;

  @override
  Future<void> cancel() async {
    TfbLogger.verbose('Cancelling sign in');
    _isCancelled = true;
  }

  @override
  Future<void> init() async {}

  @override
  bool get isAuthenticating => _isAuthenticating;

  @override
  bool get isSignedIn => _user != null;

  @override
  String? get logMessage => _logMessage;

  @override
  Future<TfbUser?> signIn({
    AuthType type = AuthType.standard,
    credentials,
  }) async {
    _isAuthenticating = true;
    _isCancelled = false;

    try {
      if (credentials is! LoginRequest) {
        return null;
      }

      TfbLogger.verbose(
        'User is attempting to sign in with email',
        credentials.username,
      );

      final loginResponse = await authClient.login(credentials);
      final loginBody = loginResponse.data;

      if (loginBody.errorMessage?.isNotEmpty ?? false) {
        throw LoginWithErrorMessageException(
          errorMessage: loginBody.errorMessage!,
        );
      }

      if (!_isCancelled) {
        const setCookieHeaderKey = 'set-cookie';
        final setCookieHeaderValue =
            loginResponse.response.headers[setCookieHeaderKey]?.join(',') ?? '';

        _user = TfbUser.fromLoginResponseAndSessionCookie(
          loginBody,
          setCookieHeaderValue,
        );
        if (_user?.emailVerified == false) {
          throw LoginWithErrorMessageException(
            errorMessage: kEmailNotVerifiedError,
          );
        }
        TfbLogger.verbose('Sign in was successful', _user);
      }

      /// If the user chose to enable biometrics we store the user object
      TfbUserRepository.instance.shouldSaveUser == true
          ? userStorageRepository.setUser(_user!)
          : userStorageRepository.clearStorage();
    } catch (e, stackTrace) {
      handleSignInError(e is Exception ? e : Exception(e.toString), stackTrace);
    }

    _isAuthenticating = false;
    _isCancelled = false;
    notifyListeners();
    return _user;
  }

  @override
  Future<void> signOut() async {
    try {
      authClient.logout();
    } catch (_) {
      // Ignore any errors with the logout call
    }

    TfbLogger.verbose('Logging out user', _user);

    _user = null;
    TfbUserRepository.instance.shouldSaveUser = false;
    await userStorageRepository.clearUser();
    notifyListeners();
  }

  @override
  void updateUser(updatedUser) {
    TfbLogger.verbose('Updating user', {
      'oldUser': _user,
      'updatedUser': updatedUser,
    });

    _user = updatedUser;
    notifyListeners();
  }

  @override
  TfbUser? get user => _user;

  void handleSignInError(Exception e, StackTrace stackTrace) {
    TfbLogger.exception('Error in AuthRepository signIn', e, stackTrace);

    _logMessage = e.toString();
    if (e is LoginWithErrorMessageException) {
      error = TfbRequestError.fromObject(
        e,
        stack: stackTrace,
        defaultMessage: e.errorMessage,
      );
    } else {
      error = TfbRequestError.fromObject(
        e,
        stack: stackTrace,
        defaultMessage: kNetworkError,
      );
    }
  }
}
