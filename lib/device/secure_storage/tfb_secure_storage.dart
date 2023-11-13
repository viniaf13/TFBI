import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/shared/constants/strings.dart';

/// Concrete implementation of the storage repo; Implement correct repository,
/// ex. TfbUserStorageRepository, not this class.
class TfbSecureStorage {
  TfbSecureStorage({required this.storage});

  final FlutterSecureStorage storage;

  TfbUser? currentUser;

  Future<bool> checkForAnyUser() async => storage.containsKey(key: kTfbUser);

  Future<bool> saveUser(TfbUser user) async {
    await clearStorageOfAllData();
    await storage.write(key: kTfbUser, value: user.toJson());
    return await getUser() != null;
  }

  Future<void> deleteUser() async => storage.delete(key: kTfbUser);

  Future<TfbUser?> getUser() async {
    final user = await storage.read(key: kTfbUser);
    return user != null ? TfbUser.fromJson(user) : null;
  }

  Future<void> clearStorageOfAllData() async => storage.deleteAll();

  Future<dynamic> readAllStorage() async => storage.readAll();
}
