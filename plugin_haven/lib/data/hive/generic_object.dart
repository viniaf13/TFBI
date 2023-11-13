import 'package:hive_flutter/adapters.dart';

//HiveType for classes
@HiveType(typeId: 0)

/// A generic object we will use for storage in Hive
///
/// Once Formatted with HiveTypes and HiveFields,
/// Type in console:
///
/// flutter packages pub run build_runner build
///
/// ! ALL custom objects must have adapters !
/// create new dart file and copy paste adapter code
/// located in .dart_tool/build/generated
/// then, import and create an adapter in main
///
/// Hive.registerAdapter(GenericObjectAdapter());
class GenericObject {
  GenericObject({
    required this.genericID,
    required this.genericName,
    required this.genericValue,
  });

  //HiveType for fields, incremental values for each field starting from 0
  @HiveField(0)
  final String genericID;
  @HiveField(1)
  final String genericName;
  @HiveField(2)
  final int genericValue;
}
