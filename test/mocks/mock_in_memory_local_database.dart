import 'package:hive/hive.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_local_database.dart';

class MockInMemoryLocalDatabase<T> implements LocalDatabase<T> {
  final Map<String, Map<dynamic, T>> _storage = {};

  Map<dynamic, T>? get box => _storage[boxName];

  @override
  String boxName = 'Test';

  @override
  Future<T> get(key) {
    return Future.value(box?[key]);
  }

  @override
  Future<Iterable<T>> getAll() async {
    final values = box?.values ?? [];
    return values.toList();
  }

  @override
  Future<void> init<A>({TypeAdapter<A>? adapter}) async {
    _storage[boxName] = {};
  }

  @override
  Future<void> put(key, T value) async {
    box?[key] = value;
  }

  @override
  Future<void> deleteAll() async {
    _storage[boxName] = {};
  }

  @override
  HiveInterface get hive => Hive;
}
