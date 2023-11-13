//  Copyright © 2023 Bottle Rocket Studios. All rights reserved.

import 'dart:core';

enum FileAClaimDestination {
  claimStar(0, 'CLAIMSTAR'),
  legacy(1, 'LEGACY');

  const FileAClaimDestination(this.value, this.name);
  final int value;
  final String name;

  int get numberValue => value;
  String get numberName => name;

  @override
  String toString() => name;
}
