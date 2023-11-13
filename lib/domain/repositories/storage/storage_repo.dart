import 'package:txfb_insurance_flutter/domain/models/login/tfb_user.dart';

/// Interface for Secure Storage. Add abstract functions here, before
/// implementing a storage repo that extends or implements this class.
abstract class StorageRepository<T extends TfbUser> {
  /// User related storage function ///
  Future<bool> setUser(TfbUser user);

  Future<TfbUser?> getUser();

  Future<void> clearUser();

  Future<bool> findUser();

  Future<void> clearStorage();
}
