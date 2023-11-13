import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_haven/network/network_connectivity_bloc/network_connectivity_bloc.dart';

import '../../mocks/mock_connection.dart';
import '../../mocks/mock_connectivity.dart';

void main() {
  late NetworkConnectivityBloc networkBloc;

  tearDown(() {
    networkBloc.close();
  });

  blocTest(
    'NetworkConnectivityBloc emits NetworkConnectedState when lookup succeeds',
    build: () {
      networkBloc = NetworkConnectivityBloc(
        connectivityChecker: MockConnectivityWifi(),
        connectionChecker: MockConnectionCheckerSuccess(),
      );
      return networkBloc;
    },
    expect: () => [isA<NetworkConnectivityConnectedState>()],
  );

  blocTest(
    'NetworkConnectivityBloc emits NetworkDisconnectedState when lookup fails',
    build: () {
      networkBloc = NetworkConnectivityBloc(
        connectivityChecker: MockConnectivityWifi(),
        connectionChecker: MockConnectionCheckerFailure(),
      );
      return networkBloc;
    },
    expect: () => [isA<NetworkConnectivityDisconnectedState>()],
  );

  blocTest(
    'NetworkConnectivityBloc emits NetworkDisconnectedState with a successful connectivity and an unsuccessful internet connection',
    build: () {
      networkBloc = NetworkConnectivityBloc(
        connectivityChecker: MockConnectivityWifi(),
        connectionChecker: MockConnectionCheckerFailure(),
      );
      return networkBloc;
    },
    expect: () => [isA<NetworkConnectivityDisconnectedState>()],
  );

  /// Even if connectivity reports that there is no internet connection, the connection checker supersedes that if it finds
  /// a valid internet connection.
  blocTest(
    'NetworkConnectivityBloc emits a NetworkConnectedState with a failed connectivity with a successful internet connection',
    build: () {
      networkBloc = NetworkConnectivityBloc(
        connectivityChecker: MockConnectivityNone(),
        connectionChecker: MockConnectionCheckerSuccess(),
      );
      return networkBloc;
    },
    expect: () => [isA<NetworkConnectivityConnectedState>()],
  );
}
