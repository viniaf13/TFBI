import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPluginHavenPlatform
    with MockPlatformInterfaceMixin
    implements WalletCardPlatform {
  @override
  Future<String?> get platformVersion => Future.value('42');

  @override
  Future<String> createPassFromTemplate({
    required String jsonTemplatePath,
    required Map<String, dynamic> templateValues,
  }) {
    // TODO: implement createPassFromTemplate
    throw UnimplementedError();
  }

  @override
  Future<bool?> deletePass({String? deleteItem}) {
    // TODO: implement deletePass
    throw UnimplementedError();
  }

  @override
  Widget getWalletIcon({ImageType? imageType, double? width, double? height}) {
    // TODO: implement getWalletIcon
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> getWalletPasses({String? id}) {
    // TODO: implement getWalletPasses
    throw UnimplementedError();
  }
}

void main() {
  final WalletCardPlatform initialPlatform = WalletCardPlatform.instance;

  test('$WalletCardPlatform is the default instance', () {
    expect(initialPlatform, isInstanceOf<WalletCardPlatform>());
  });

  test('getPlatformVersion', () async {
    MockPluginHavenPlatform fakePlatform = MockPluginHavenPlatform();
    WalletCardPlatform.instance = fakePlatform;

    expect(await WalletCardPlatform.instance.platformVersion, '42');
  });
}
