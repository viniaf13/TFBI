// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:plugin_haven/plugin_haven.dart';

class ExampleUser extends HavenUser {}

class AutomaticSignInAuthRepository extends AuthRepository<ExampleUser> {
  ExampleUser? _user;

  @override
  ExampleUser? get user => _user;

  @override
  Future<void> cancel() async {
    _user = null;
    notifyListeners();
  }

  @override
  String? get logMessage => '';

  @override
  Future<ExampleUser?> signIn({
    AuthType type = AuthType.standard,
    dynamic credentials,
  }) async {
    _user = ExampleUser();
    notifyListeners();
    return _user;
  }

  @override
  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 1));
    notifyListeners();
  }

  @override
  bool get isAuthenticating => false;

  @override
  bool get isSignedIn => _user != null;

  @override
  Future signOut() async {
    _user = null;
    notifyListeners();
  }

  @override
  void updateUser(ExampleUser updatedUser) {
    _user = updatedUser;
    notifyListeners();
  }
}
