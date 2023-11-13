extension ListIsNullOrEmpty on List<dynamic>? {
  bool get isNullOrEmpty => this == null || (this != null && this!.isEmpty);
}

extension GroupBy<T> on List<T> {
  Map<K, List<T>> groupBy<K>(K Function(T) keySelector) {
    final groupedMap = <K, List<T>>{};

    asMap().forEach((index, item) {
      final key = keySelector(item);
      groupedMap.putIfAbsent(key, () => []);
      groupedMap[key]!.add(item);
    });

    return groupedMap;
  }
}
