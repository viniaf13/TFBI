part of 'autopay_bloc.dart';

sealed class AutopayState extends Equatable {
  const AutopayState();

  @override
  List<Object> get props => [];
}

final class AutopayInitial extends AutopayState {}

final class AutopayCancelled extends AutopayState {}

final class AutopayProcessing extends AutopayState {}

final class AutopaySuccessful extends AutopayState {}

final class AutopayDiscontinueSuccess extends AutopayState {}

final class AutopayFailed extends AutopayState {
  const AutopayFailed(this.error);

  final TfbRequestError error;
}

final class DiscontinueAutopayFailed extends AutopayState {
  const DiscontinueAutopayFailed(this.error);

  final TfbRequestError error;
}
