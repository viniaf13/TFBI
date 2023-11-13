part of 'network_connectivity_bloc.dart';

@immutable
abstract class NetworkConnectivityState extends Equatable {
  const NetworkConnectivityState();

  @override
  List<Object> get props => [];
}

class NetworkConnectivityInitialState extends NetworkConnectivityState {}

class NetworkConnectivityConnectedState extends NetworkConnectivityState {}

class NetworkConnectivityDisconnectedState extends NetworkConnectivityState {}
