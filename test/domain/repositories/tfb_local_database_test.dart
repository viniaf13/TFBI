import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_local_database.dart';

class MockHive extends Mock implements HiveInterface {}

class MockBox<E> extends Mock implements Box<E> {}

void main() {
  group('LocalDatabase', () {
    late MockHive mockHive;
    late Box<dynamic> mockBox;
    late LocalDatabase<dynamic> localDatabase;

    setUp(() async {
      final path = Directory.systemTemp.path;
      Hive.init(path);
      mockHive = MockHive();
      mockBox = MockBox();
      localDatabase = LocalDatabase('test_box', hive: mockHive);
      when(() => mockHive.openBox<dynamic>(any()))
          .thenAnswer((_) async => mockBox);
      when(() => mockBox.put(any<dynamic>(), any<dynamic>()))
          .thenAnswer((_) async => <void>{});
      when(() => mockBox.delete(any<dynamic>()))
          .thenAnswer((_) async => <void>{});
      when(() => mockBox.deleteFromDisk()).thenAnswer((_) async => <void>{});
    });

    tearDown(() async {
      final box = await Hive.openBox<dynamic>('test_box');
      await box.clear();
      await Hive.deleteBoxFromDisk('test_box');
    });

    test('init opens a box', () async {
      await localDatabase.init<dynamic>();
      verify(() => mockHive.openBox<dynamic>('test_box')).called(1);
    });

    test('get retrieves a value', () async {
      when(() => mockBox.get(any<dynamic>())).thenReturn('test_value');
      final result = await localDatabase.get('test_key');
      expect(result, 'test_value');
      verify(() => mockBox.get('test_key')).called(1);
    });

    test('getAll retrieves all values', () async {
      when(() => mockBox.values).thenReturn(['test_value']);
      final result = await localDatabase.getAll();
      expect(result, ['test_value']);
    });

    test('put inserts a value', () async {
      await localDatabase.put('test_key', 'test_value');
      verify(() => mockBox.put('test_key', 'test_value')).called(1);
    });

    test('put deletes a value if it is null', () async {
      await localDatabase.put('test_key', null);
      verify(() => mockBox.delete('test_key')).called(1);
    });

    test('deleteAll deletes all values', () async {
      await localDatabase.deleteAll();
      verify(() => mockBox.deleteFromDisk()).called(1);
    });
  });
}
