import 'dart:io';
import 'dart:typed_data';

class MockInternetAddressSuccessfulLookup implements InternetAddress {
  MockInternetAddressSuccessfulLookup() : super();

  static Future<List<InternetAddress>> lookup(
    String url, {
    InternetAddressType type = InternetAddressType.any,
  }) {
    return Future.value([InternetAddress('1.1.1.1')]);
  }

  @override
  Future<InternetAddress> reverse() {
    throw UnimplementedError();
  }

  @override
  String get address => throw UnimplementedError();

  @override
  String get host => throw UnimplementedError();

  @override
  bool get isLoopback => throw UnimplementedError();

  @override
  bool get isLinkLocal => throw UnimplementedError();

  @override
  bool get isMulticast => throw UnimplementedError();

  @override
  InternetAddressType get type => throw UnimplementedError();

  @override
  Uint8List get rawAddress => throw UnimplementedError();
}

class MockInternetAddressFailedLookup
    extends MockInternetAddressSuccessfulLookup {
  static Future<List<InternetAddress>> lookup(
    String url, {
    InternetAddressType type = InternetAddressType.any,
  }) {
    return Future.error([]);
  }
}
