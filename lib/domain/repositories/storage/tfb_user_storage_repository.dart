import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/device/secure_storage/tfb_secure_storage.dart';
import 'package:txfb_insurance_flutter/domain/models/login/tfb_user.dart';
import 'package:txfb_insurance_flutter/domain/repositories/storage/storage_repo.dart';

/// Repository for user storage. Storage functions not pertaining to the user
/// should not live here.
class TfbUserStorageRepository<T extends TfbUser> implements StorageRepository {
  TfbUserStorageRepository({
    required this.storage,
  });

  TfbSecureStorage storage;

  TfbUser? get currentUser => storage.currentUser;

  @override
  Future<void> clearUser() async => storage.deleteUser();

  @override
  Future<bool> findUser() async => storage.checkForAnyUser();

  @override
  Future<TfbUser?> getUser() async => storage.getUser();

  @override
  Future<bool> setUser(TfbUser user) async => storage.saveUser(user);

  @override
  Future<void> clearStorage() => storage.clearStorageOfAllData();
}
