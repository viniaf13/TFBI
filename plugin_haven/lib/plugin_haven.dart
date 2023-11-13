import 'package:plugin_haven/haven.dart';

export 'haven.dart';

class PluginHaven {
  Future<String?> getPlatformVersion() {
    return WalletCardPlatform.instance.platformVersion;
  }
}
