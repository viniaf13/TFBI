// coverage:ignore-file

import 'package:plugin_haven/plugin_haven.dart';

abstract class MixpanelProjectToken {
  static String get staging => _stagingToken.value;
  static final ObfuscatedKey _stagingToken = const ObfuscatedKey()
      .n9
      .n9
      .n2
      .n3
      .b
      .n4
      .c
      .n1
      .c
      .b
      .a
      .b
      .c
      .c
      .n8
      .n6
      .n9
      .b
      .n5
      .e
      .n5
      .n4
      .n9
      .n8
      .e
      .c
      .n3
      .n3
      .n9
      .b
      .n2
      .a;

  static String get prod => _prodToken.value;
  static final ObfuscatedKey _prodToken = const ObfuscatedKey()
      .n8
      .n3
      .e
      .e
      .n2
      .n9
      .n0
      .n5
      .n3
      .a
      .f
      .n2
      .n6
      .n2
      .n9
      .n9
      .n3
      .n8
      .e
      .n7
      .d
      .n4
      .b
      .b
      .n6
      .c
      .d
      .n1
      .e
      .f
      .a
      .n1;
}
