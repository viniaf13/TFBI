part of 'status_bar_scroll_cubit.dart';

sealed class StatusBarScrollState extends Equatable {
  const StatusBarScrollState(this.pathOfScreenTapped);

  @override
  List<Object> get props => [];
  final String pathOfScreenTapped;
}

final class StatusBarScrollInitial extends StatusBarScrollState {
  const StatusBarScrollInitial(super.pathOfScreenTapped);
}

final class StatusBarScrollActive extends StatusBarScrollState {
  const StatusBarScrollActive(super.pathOfScreenTapped);
}
