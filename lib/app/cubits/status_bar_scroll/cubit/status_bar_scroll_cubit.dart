import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'status_bar_scroll_state.dart';

class StatusBarScrollCubit extends Cubit<StatusBarScrollState> {
  StatusBarScrollCubit() : super(const StatusBarScrollInitial(''));

  void emitScrollNotification(String location) {
    emit(StatusBarScrollActive(location));
  }

  void resetScrollNotification(String location) {
    emit(StatusBarScrollInitial(location));
  }
}
