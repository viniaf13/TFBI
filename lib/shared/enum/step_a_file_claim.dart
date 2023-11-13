import 'dart:core';

enum StepFileAClaim {
  reporter(0, '1', 'REPORTER'),
  lossDamage(1, '2', 'LOSS/DAMAGE');

  const StepFileAClaim(this.value, this.name, this.title);
  final int value;
  final String name;
  final String title;

  int get numberValue => value;
  String get numberName => name;

  @override
  String toString() => name;
}
