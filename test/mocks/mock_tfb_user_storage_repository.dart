import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/domain/repositories/storage/tfb_user_storage_repository.dart';

class MockTfbUserStorageRepository extends Mock
    implements TfbUserStorageRepository {
  @override
  Future<void> clearStorage() {
    return Future.value();
  }
}
