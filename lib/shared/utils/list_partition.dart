/// How To Partition A List:
///     final partitioned = partition(
///       listToPartition,
///       test: (item) => binary attribute to filter list by,
///     );
///
///     final trueList = partitioned.first;
///     final falseList = partitioned.last;
library;

List<List<T>> partition<T>(
  List<T> list, {
  required bool Function(T element) test,
}) =>
    [
      list.where(test).toList(),
      list.where((e) => !test(e)).toList(),
    ];
