class LoginException implements Exception {}

class LoginWithErrorMessageException extends LoginException {
  LoginWithErrorMessageException({
    required this.errorMessage,
  });

  String errorMessage;

  @override
  String toString() {
    return 'LoginWithErrorMessageException: $errorMessage';
  }
}
