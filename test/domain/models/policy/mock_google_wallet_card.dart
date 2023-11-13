import 'package:plugin_haven/wallet/wallet_card_google.dart';

class MockGoogleWalletCard extends GoogleWalletCard {
  String passId = 'mockPassId';

  @override
  Future<String> createPassFromTemplate({
    required String jsonTemplatePath,
    required Map<String, dynamic> templateValues,
  }) async {
    return passId;
  }
}
