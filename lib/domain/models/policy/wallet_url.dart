import 'dart:io';

import 'package:txfb_insurance_flutter/data/data.dart';

class WalletUrl {
  String get url {
    return Platform.isIOS ? kAppleWalletUrl : kGoogleWalletUrl;
  }
}
