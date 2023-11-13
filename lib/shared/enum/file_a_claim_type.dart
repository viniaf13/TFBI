import 'dart:core';

enum FileAClaimType {
  auto(0, 'AUTO'),
  lossDamage(1, 'PROPERTY');

  const FileAClaimType(this.value, this.name);
  final int value;
  final String name;

  int get numberValue => value;
  String get numberName => name;

  @override
  String toString() => name;
}
