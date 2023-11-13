import 'package:connectivity_plus/connectivity_plus.dart';

class MockConnectivityWifi implements Connectivity {
  @override
  Future<ConnectivityResult> checkConnectivity() {
    return Future.value(ConnectivityResult.wifi);
  }

  @override
  Stream<ConnectivityResult> get onConnectivityChanged {
    return Stream.value(ConnectivityResult.wifi);
  }
}

class MockConnectivityNone implements Connectivity {
  @override
  Future<ConnectivityResult> checkConnectivity() {
    return Future.value(ConnectivityResult.none);
  }

  @override
  Stream<ConnectivityResult> get onConnectivityChanged {
    return Stream.value(ConnectivityResult.none);
  }
}
