import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:txfb_insurance_flutter/data/storage/login_remember_me_store.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('LoginRememberMeStore', () {
    late LoginRememberMeStore store;
    late MockSharedPreferences prefs;

    const String testEmail = 'test@email.com';
    const String rememberMeStorageKey = 'remember_me_storage_key';

    setUp(() {
      prefs = MockSharedPreferences();
      store = LoginRememberMeStore(prefs: prefs);
    });

    test('stores email correctly', () async {
      when(() => prefs.setString(rememberMeStorageKey, testEmail))
          .thenAnswer((_) async => Future.value(true));
      await store.store(email: testEmail);
      verify(() => prefs.setString(rememberMeStorageKey, testEmail)).called(1);
    });

    test('retrieves stored email correctly', () async {
      when(() => prefs.getString(rememberMeStorageKey)).thenReturn(testEmail);
      final storedEmail = await store.get();
      verify(() => prefs.getString(rememberMeStorageKey)).called(1);
      expect(storedEmail, equals(testEmail));
    });

    test('returns null if no email stored', () async {
      when(() => prefs.getString(rememberMeStorageKey)).thenReturn('');
      final storedEmail = await store.get();
      expect(storedEmail, null);
    });

    test('clears stored email correctly', () async {
      when(() => prefs.setString(rememberMeStorageKey, ''))
          .thenAnswer((_) async => Future.value(true));
      await store.clear();
      verify(() => prefs.setString(rememberMeStorageKey, '')).called(1);
    });
  });
}
