/// Globally accessible User Repository. This is where we will store user
/// information and preferences that will need to be accessed throughout the
/// application.
/// To call the repo: TfbUserRepository.instance.[whatever function or variable you need to access]
class TfbUserRepository {
  TfbUserRepository._();
  static final TfbUserRepository _instance = TfbUserRepository._();
  static TfbUserRepository get instance => _instance;

  /// Used to determine if we should store the user object on sign in
  /// We store the user object to use with sing in via local auth (biometrics)
  bool shouldSaveUser = false;
}
