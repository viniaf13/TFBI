import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/device/secure_storage/tfb_secure_storage.dart';
import 'package:txfb_insurance_flutter/domain/models/login/login_member.dart';
import 'package:txfb_insurance_flutter/domain/models/login/tfb_user.dart';
import 'package:txfb_insurance_flutter/domain/repositories/storage/tfb_user_storage_repository.dart';

final TfbUser testUser = TfbUser(
  accessToken: 'testAccessToken',
  username: 'username',
  agentNumber: 'agentNumber',
  communicationPreferred: 'communicationPreferred',
  emailVerified: true,
  errorMessage: 'errorMessage',
  memberName: 'memberName',
  memberSecondaryName: 'memberSecondaryName',
  passwordResetFlag: false,
  sessionCookie: 'sessionCookie',
  memberEmailAddress: 'memberEmailAddress',
  members: [
    LoginMember(
      lastLoginTimestamp: 'lastLoginTimestamp',
      memberIDNumber: 1234,
      memberNumber: '1234',
    ),
  ],
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const secureStorage = FlutterSecureStorage();
  FlutterSecureStorage.setMockInitialValues(<String, String>{});
  final TfbSecureStorage storage = TfbSecureStorage(storage: secureStorage);
  final TfbUserStorageRepository repository =
      TfbUserStorageRepository<TfbUser>(storage: storage);

  group('TfbSecureStorage Tests', () {
    test('saveUser: positive', () async {
      expect(await storage.saveUser(testUser), isTrue);
    });

    test('getUser: positive', () async {
      await storage.saveUser(testUser);
      final retrievedUser = await storage.getUser();
      expect(retrievedUser, isNotNull);
      expect(retrievedUser, equals(testUser));
    });

    test('getUser: negative', () async {
      await storage.deleteUser();
      expect(await storage.getUser(), isNull);
    });

    test('checkForAnyUser: positive', () async {
      await storage.saveUser(testUser);
      expect(await storage.checkForAnyUser(), isTrue);
    });

    test('checkForAnyUser: negative', () async {
      await storage.deleteUser();
      expect(await storage.checkForAnyUser(), isFalse);
    });

    test('deleteUser: positive', () async {
      await storage.saveUser(testUser);
      await storage.deleteUser();
      expect(await storage.getUser(), isNull);
    });

    test('deleteUser: negative', () async {
      await storage.deleteUser();
      await storage.saveUser(testUser);
      expect(await storage.getUser(), isNotNull);
    });

    test('clearStorageOfAllData: positive', () async {
      await storage.saveUser(testUser);
      await storage.clearStorageOfAllData();
      expect(await storage.getUser(), isNull);
    });

    test('clearStorageOfAllData: negative', () async {
      await storage.clearStorageOfAllData();
      await storage.saveUser(testUser);
      expect(await storage.getUser(), isNotNull);
    });

    test('readAllStorage: positive', () async {
      await storage.saveUser(testUser);
      final allData = await storage.readAllStorage();
      expect(allData, isNotEmpty);
    });

    test('readAllStorage: negative', () async {
      await storage.clearStorageOfAllData();
      final allData = await storage.readAllStorage();
      expect(allData, isEmpty);
    });
  });

  test('clearUser', () async {
    await repository.setUser(testUser);
    await repository.clearUser();

    expect(await repository.getUser(), null);
  });

  test('findUser', () async {
    await repository.setUser(testUser);
    final result = await repository.findUser();

    expect(result, true);
  });

  test('getUser', () async {
    await repository.setUser(testUser);
    final result = await repository.getUser();

    expect(result, testUser);
  });

  test('setUser', () async {
    await repository.clearStorage();
    expect(await repository.findUser(), false);
    await repository.setUser(testUser);

    expect(await repository.getUser(), testUser);
  });

  test('clearStorage', () async {
    await repository.clearStorage();

    expect(await repository.findUser(), false);
  });
}
