import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plugin_haven/data/hive/basic_hive_repository.dart';
import 'package:plugin_haven/data/hive/generic_object.dart';

part 'basic_hive_event.dart';
part 'basic_hive_state.dart';

/// BasicHiveBloc
///
/// Manages business logic when adding, deleting, updating,
/// and clearing a hive box
/// To utilize: Change 'GenericObject' instances everywhere in the Repo
/// and basic_hive_bloc folder to the object of your choosing
///
/// read documentation above each file for further instructions
class BasicHiveBloc extends Bloc<BasicHiveEvent, BasicHiveState> {
  BasicHiveBloc({required BasicHiveRepository theRepo})
      : _db = theRepo,
        super(BasicHiveLoading()) {
    on<BasicHiveLoad>(_onBasicHiveLoad);
    on<BasicHiveUpdated>(_onBasicHiveUpdated);
    on<BasicHiveAdd>(_onBasicHiveAdd);
    on<BasicHiveDelete>(_onBasicHiveDelete);
    on<BasicHiveUpdate>(_onBasicHiveUpdate);
    on<BasicHiveClearDB>(_onBasicHiveClearDB);
  }

  final BasicHiveRepository _db;

  Future<void> _onBasicHiveLoad(
    BasicHiveLoad event,
    Emitter<BasicHiveState> emit,
  ) async {
    add(BasicHiveUpdated(objects: await _db.getObjects()));
  }

  Future<void> _onBasicHiveUpdated(
    BasicHiveUpdated event,
    Emitter<BasicHiveState> emit,
  ) async {
    emit(BasicHiveLoaded(objects: event.objects));
  }

  Future<void> _onBasicHiveAdd(
    BasicHiveAdd event,
    Emitter<BasicHiveState> emit,
  ) async {
    await _db.updateObject(event.object);
    add(BasicHiveUpdated(objects: await _db.getObjects()));
  }

  Future<void> _onBasicHiveDelete(
    BasicHiveDelete event,
    Emitter<BasicHiveState> emit,
  ) async {
    await _db.deleteObject(event.objectID);
    add(BasicHiveUpdated(objects: await _db.getObjects()));
  }

  Future<void> _onBasicHiveUpdate(
    BasicHiveUpdate event,
    Emitter<BasicHiveState> emit,
  ) async {
    await _db.updateObject(event.object);
    add(BasicHiveUpdated(objects: await _db.getObjects()));
  }

  Future<void> _onBasicHiveClearDB(
    BasicHiveClearDB event,
    Emitter<BasicHiveState> emit,
  ) async {
    await _db.clearDB();
  }
}
