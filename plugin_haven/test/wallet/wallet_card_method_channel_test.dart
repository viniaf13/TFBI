import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_haven/wallet/wallet_card_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(WalletCardPlatform.channel,
            (MethodCall methodCall) async {
      if (methodCall.method == 'getPlatformVersion') {
        return '42';
      } else if (methodCall.method == '') {}
      return '';
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(WalletCardPlatform.channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await WalletCardPlatform.instance.platformVersion, '42');
  });
}
