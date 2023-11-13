import 'package:shared_preferences/shared_preferences.dart';

const rememberMeStorageKey = 'remember_me_storage_key';

class LoginRememberMeStore {
  LoginRememberMeStore({
    required this.prefs,
  });

  SharedPreferences prefs;

  static Future<SharedPreferences> getDefaultSharedPrefs() =>
      SharedPreferences.getInstance();

  Future<void> store({required String email}) async {
    await prefs.setString(rememberMeStorageKey, email);
  }

  Future<String?> get() async {
    final storedString = prefs.getString(rememberMeStorageKey);
    return (storedString?.isEmpty ?? false) ? null : storedString;
  }

  Future<void> clear() async {
    await prefs.setString(rememberMeStorageKey, '');
  }
}
