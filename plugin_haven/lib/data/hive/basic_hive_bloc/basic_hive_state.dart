part of 'basic_hive_bloc.dart';

abstract class BasicHiveState extends Equatable {
  const BasicHiveState();

  @override
  List<Object> get props => [];
}

class BasicHiveLoading extends BasicHiveState {}

class BasicHiveLoaded extends BasicHiveState {
  const BasicHiveLoaded({required this.objects});
  final Map<String, GenericObject> objects;
  @override
  List<Object> get props => [objects];
}
