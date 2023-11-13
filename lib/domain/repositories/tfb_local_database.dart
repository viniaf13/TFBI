import 'package:hive/hive.dart';

/// Where E represents the type of the value put into the box
class LocalDatabase<E> {
  LocalDatabase(this.boxName, {required this.hive});

  final String boxName;
  final HiveInterface hive;

  Future<void> init<T>({TypeAdapter<T>? adapter}) async {
    if (adapter != null) {
      hive.registerAdapter<T>(adapter);
    }
    await hive.openBox<E>(boxName);
    return;
  }

  Future<dynamic> get(dynamic key) async {
    final box = await hive.openBox<E>(boxName);
    return box.get(key);
  }

  Future<Iterable<dynamic>> getAll() async {
    final box = await hive.openBox<E>(boxName);
    return box.values.toList();
  }

  Future<void> put(dynamic key, E value) async {
    final box = await hive.openBox<E>(boxName);
    if (value == null) {
      return box.delete(key);
    } else {
      return box.put(key, value);
    }
  }

  Future<void> deleteAll() async {
    final box = await hive.openBox<E>(boxName);
    await box.deleteFromDisk();
  }
}
