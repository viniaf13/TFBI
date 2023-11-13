part of 'basic_hive_bloc.dart';

abstract class BasicHiveEvent extends Equatable {
  const BasicHiveEvent();
  @override
  List<Object> get props => [];
}

class BasicHiveLoad extends BasicHiveEvent {}

class BasicHiveUpdated extends BasicHiveEvent {
  const BasicHiveUpdated({required this.objects});
  final Map<String, GenericObject> objects;
  @override
  List<Object> get props => [objects];
}

class BasicHiveAdd extends BasicHiveEvent {
  const BasicHiveAdd({required this.object});
  final GenericObject object;
  @override
  List<Object> get props => [object];
}

class BasicHiveDelete extends BasicHiveEvent {
  const BasicHiveDelete({required this.objectID});
  final String objectID;
  @override
  List<Object> get props => [objectID];
}

class BasicHiveUpdate extends BasicHiveEvent {
  const BasicHiveUpdate({required this.object});
  final GenericObject object;
  @override
  List<Object> get props => [object];
}

class BasicHiveClearDB extends BasicHiveEvent {}
