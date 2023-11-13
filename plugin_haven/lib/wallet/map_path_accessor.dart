/// Extension: MapAccessorPath
/// Copyright © 2023 Bottle Rocket Studios. All rights reserved.
///
/// This extension provides utility methods for accessing and manipulating
/// nested values in a `Map<String, dynamic>` object. The Extension uses paths,
/// e.g. 'a/b/c', to access objects found in compound map derived from json
/// constructs.
///
extension MapAccessorPath on Map<String, dynamic> {
  static String _delimiter = '/';

  // Change default path separator from '/' to alternate String delimiter
  // for subsequent path functions.
  static set delimiter(String delimiter) {
    _delimiter = delimiter;
  }

  /* Example for findPathList
     final map = {'foo': {'bar': {'baz': 42,},},};
     final value = map.findPathList(['foo', 'bar', 'baz']);
     print(value); // Output: 42
  */
  dynamic findPathList(List<String> keys) {
    dynamic current = this;

    for (String key in keys) {
      if (current is Map<String, dynamic> && current.containsKey(key)) {
        current = current[key];
      } else if (current is List) {
        final int? index = int.tryParse(key);
        if (index != null && index < current.length && index >= 0) {
          current = current[index];
        }
      } else {
        return null;
      }
    }
    return current;
  }

  /* Example for containsPath
     final map = {'foo': {'bar': {'baz': 42,},},};
     print(map.containsPath('foo/bar/baz'));  // Output: true
  */
  bool containsPath(String path) {
    return findPathList(path.split(_delimiter)) != null;
  }

  /* Example for getPath
     final map = {'foo': {'bar': {'baz': 42,},},};
     print(map.getPath('foo/bar/baz'));  // Output: 42
  */
  dynamic getPath(String path) {
    return findPathList(path.split(_delimiter));
  }

  /*  Examples for putPath
      final map = {'foo': ['a', 'b',], 'bar': {'number': '1'},};

      map.putPath('foo/2', 'c');
      print(map); // Output: { 'foo': [ 'a', 'b', 'c' ], 'bar': {'number': '1'}}
      map.putPath('bar/number', 47);
      print(map); // Output: { 'foo': [ 'a', 'b', 'c' ], 'bar': {'number': 47}}
  */
  void putPath(String path, dynamic value) {
    final List<String> keys = path.split(_delimiter);
    final dynamic current = findPathList(keys.sublist(0, keys.length - 1));

    if (current != null) {
      final String lastKey = keys.last;

      if (current is Map<String, dynamic>) {
        current[lastKey] = value;
      } else if (current is List) {
        final int? index = int.tryParse(lastKey);
        if (index != null) {
          if (index >= 0 && index < current.length) {
            current[index] = value;
          } else {
            current.add(value);
          }
        }
      }
    }
  }
}
