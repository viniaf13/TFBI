import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'network_connectivity_event.dart';
part 'network_connectivity_state.dart';

class NetworkConnectivityBloc
    extends Bloc<NetworkConnectivityEvent, NetworkConnectivityState> {
  NetworkConnectivityBloc({
    required this.connectionChecker,
    required this.connectivityChecker,
  }) : super(NetworkConnectivityInitialState()) {
    on<_NetworkConnectivityInitEvent>(_init);
    on<NetworkConnectivityCheckEvent>(
      (_, emit) async {
        setConnectivityConnected(await connectionChecker.hasConnection);
      },
      transformer: droppable(),
    );
    on<_NetworkConnectivityConnectedEvent>((_, emit) {
      emit(NetworkConnectivityConnectedState());
    });
    on<_NetworkConnectivityDisconnectedEvent>((_, emit) {
      emit(NetworkConnectivityDisconnectedState());
    });

    add(_NetworkConnectivityInitEvent());
  }

  final InternetConnectionChecker connectionChecker;
  final Connectivity connectivityChecker;

  late StreamSubscription _connectivityStream;
  late StreamSubscription _connectionStream;

  Future<void> _init(
    _NetworkConnectivityInitEvent event,
    Emitter<NetworkConnectivityState> emit,
  ) async {
    /// Connections stream updates the connection status on a periodic interval
    /// regardless of the network connectivity
    _connectionStream =
        connectionChecker.onStatusChange.listen(_onChangeConnection);

    /// Connectivity stream updates the connection status when the network
    /// connectivity changes. Eg. from wifi to mobile data
    _connectivityStream =
        connectivityChecker.onConnectivityChanged.listen(_onChangeConnectivity);
  }

  /// When the network connectivity changes, eg. switching from wifi to mobile,
  /// or turning wifi off entirely, we need to check the connection status
  /// again with the connection checker.
  Future<void> _onChangeConnectivity(
    ConnectivityResult connectivityResult,
  ) async {
    add(NetworkConnectivityCheckEvent());
  }

  /// Periodically checks the connection status and sets the connectivity status
  /// accordingly.
  Future<void> _onChangeConnection(
    InternetConnectionStatus connectivityResult,
  ) async {
    add(NetworkConnectivityCheckEvent());
  }

  void setConnectivityConnected(bool isConnected) {
    if (isConnected) {
      add(_NetworkConnectivityConnectedEvent());
    } else {
      add(_NetworkConnectivityDisconnectedEvent());
    }
  }

  @override
  Future<void> close() async {
    await _connectionStream.cancel();
    await _connectivityStream.cancel();
    return super.close();
  }
}
