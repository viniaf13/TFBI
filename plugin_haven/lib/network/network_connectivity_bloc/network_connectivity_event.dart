part of 'network_connectivity_bloc.dart';

@immutable
abstract class NetworkConnectivityEvent {}

class _NetworkConnectivityInitEvent extends NetworkConnectivityEvent {}

class _NetworkConnectivityConnectedEvent extends NetworkConnectivityEvent {}

class NetworkConnectivityCheckEvent extends NetworkConnectivityEvent {}

class _NetworkConnectivityDisconnectedEvent extends NetworkConnectivityEvent {}
