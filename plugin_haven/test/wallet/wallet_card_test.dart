import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_haven/wallet/wallet_card_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWalletCardPlatform
    with MockPlatformInterfaceMixin
    implements WalletCardPlatform {
  @override
  Future<String?> get platformVersion => Future.value('42');

  @override
  Future<String> createPassFromTemplate({
    required String jsonTemplatePath,
    required Map<String, dynamic> templateValues,
  }) {
    throw UnimplementedError(
      'createPassFromTemplate() has not been implemented.',
    );
  }

  @override
  Future<bool?> deletePass({String? deleteItem}) {
    throw UnimplementedError('deletePass() has not been implemented.');
  }

  @override
  Future<List<Map<String, dynamic>>> getWalletPasses({String? id}) {
    throw UnimplementedError('getter walletPasses has not been implemented.');
  }

  @override
  Widget getWalletIcon({ImageType? imageType, double? width, double? height}) {
    throw UnimplementedError('getWalletIcon() has not been implemented.');
  }
}

void main() {
  final WalletCardPlatform initialPlatform = WalletCardPlatform.instance;

  test('$WalletCardPlatform is the default instance', () {
    expect(initialPlatform, isInstanceOf<WalletCardPlatform>());
  });

  test('getPlatformVersion', () async {
    MockWalletCardPlatform fakePlatform = MockWalletCardPlatform();
    WalletCardPlatform.instance = fakePlatform;

    expect(await WalletCardPlatform.instance.platformVersion, '42');
  });
}
