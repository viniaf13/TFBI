import 'package:internet_connection_checker/internet_connection_checker.dart';

class MockConnectionCheckerSuccess implements InternetConnectionChecker {
  @override
  List<AddressCheckOptions> addresses = [];

  @override
  Duration get checkInterval => throw UnimplementedError();

  @override
  Duration get checkTimeout => throw UnimplementedError();

  @override
  Future<InternetConnectionStatus> get connectionStatus =>
      throw UnimplementedError();

  @override
  Future<bool> get hasConnection => Future.value(true);

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  bool get isActivelyChecking => throw UnimplementedError();

  @override
  Future<AddressCheckResult> isHostReachable(AddressCheckOptions options) {
    throw UnimplementedError();
  }

  @override
  Stream<InternetConnectionStatus> get onStatusChange =>
      Stream.value(InternetConnectionStatus.connected);
}

class MockConnectionCheckerFailure extends MockConnectionCheckerSuccess {
  @override
  Future<bool> get hasConnection => Future.value(false);

  @override
  Stream<InternetConnectionStatus> get onStatusChange =>
      Stream.value(InternetConnectionStatus.disconnected);
}
