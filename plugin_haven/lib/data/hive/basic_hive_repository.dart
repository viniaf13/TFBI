import 'package:plugin_haven/data/hive/generic_object.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// BasicHiveRepository
/// our direct contact with the Hive instance
///
///in Main:
/// WidgetsFlutterBinding.ensureInitialized();
/// if (!kIsWeb) {
/// await Hive.initFlutter();
/// }
/// //Any Hive Adapters (See GenericObject)
/// await Hive.openBox('box_name');
///
///in Pubspec:
/// dependencies:
/// hive_flutter, hive, path_provider
/// dev dependencies:
/// hive_generator, build_runner
///

class BasicHiveRepository {
  BasicHiveRepository({required String boxName}) {
    _localDB = Hive.box<GenericObject>(boxName);
  }

  late Box<GenericObject> _localDB;

  Future<void> updateObject(GenericObject object) async =>
      await _localDB.put(object.genericID, object);

  Future<void> deleteObject(String objectID) async =>
      await _localDB.delete(objectID);

  Future<void> updateObjects(List<GenericObject> objects) async {
    for (var object in objects) {
      await _localDB.put(object.genericID, object);
    }
  }

  Future<Map<String, GenericObject>> getObjects() async {
    return Map<String, GenericObject>.from(_localDB.toMap());
  }

  Future<void> clearDB() async {
    await _localDB.clear();
  }
}
