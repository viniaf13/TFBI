import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_haven/wallet/map_path_accessor.dart';

void main() {
  group('MapAccessorPath Extension', () {
    test('findPathList - existing path', () {
      final map = {
        'foo': {
          'bar': {
            'baz': 42,
          },
        },
      };

      final value = map.findPathList(['foo', 'bar', 'baz']);
      expect(value, equals(42));
    });

    test('findPathList - non-existing path', () {
      final map = {
        'foo': {
          'bar': {
            'baz': 42,
          },
        },
      };

      final value = map.findPathList(['foo', 'nonexistent', 'baz']);
      expect(value, isNull);
    });

    test('containsPath - existing path', () {
      final map = {
        'foo': {
          'bar': {
            'baz': 42,
          },
        },
      };

      final containsPath = map.containsPath('foo/bar/baz');
      expect(containsPath, isTrue);
    });

    test('containsPath - non-existing path', () {
      final map = {
        'foo': {
          'bar': {
            'baz': 42,
          },
        },
      };

      final containsPath = map.containsPath('foo/nonexistent/baz');
      expect(containsPath, isFalse);
    });

    test('getPath - existing path', () {
      final map = {
        'foo': {
          'bar': {
            'baz': 42,
          },
        },
      };

      final value = map.getPath('foo/bar/baz');
      expect(value, equals(42));
    });

    test('getPath - non-existing path', () {
      final map = {
        'foo': {
          'bar': {
            'baz': 42,
          },
        },
      };

      final value = map.getPath('foo/nonexistent/baz');
      expect(value, isNull);
    });

    test('putPath - existing path', () {
      final map = {
        'foo': {
          'bar': {
            'baz': 42,
          },
        },
      };

      map.putPath('foo/bar/baz', 47);
      expect(
        map,
        equals({
          'foo': {
            'bar': {'baz': 47}
          }
        }),
      );
    });

    test('putPath - existing list index', () {
      final map = {
        'foo': [
          'a',
          'b',
        ],
      };

      map.putPath('foo/1', 'c');
      expect(
        map,
        equals({
          'foo': ['a', 'c']
        }),
      );
    });

    test('putPath - non-existing path', () {
      final Map<String, dynamic> map = {};

      map.putPath('foo/bar/baz', 42);
      expect(map, equals({}));
    });

    test('putPath - non-existing list index', () {
      final map = {
        'foo': [
          'a',
          'b',
        ],
      };

      map.putPath('foo/2', 'c');
      expect(
        map,
        equals({
          'foo': ['a', 'b', 'c']
        }),
      );
    });

    test('putPath - negative list index (appends at end also)', () {
      final map = {
        'foo': [
          'a',
          'b',
        ],
      };

      map.putPath('foo/-1', 'c');
      expect(
        map,
        equals({
          'foo': ['a', 'b', 'c']
        }),
      );
    });
  });
}
