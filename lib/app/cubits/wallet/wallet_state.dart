part of 'wallet_cubit.dart';

sealed class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

final class WalletInitial extends WalletState {}

final class WalletSuccess extends WalletState {
  const WalletSuccess();
}

final class WalletFailure extends WalletState {
  const WalletFailure(this.error);
  final Object error;

  @override
  List<Object> get props => [error];
}

final class WalletProcessing extends WalletState {}
