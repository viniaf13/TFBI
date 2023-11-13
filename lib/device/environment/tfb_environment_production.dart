// coverage:ignore-file
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment.dart';

class TfbEnvironmentProduction extends TfbEnvironment {
  @override
  String get apiUrl => kProductionApiBaseUrl;

  @override
  String get websiteUrl => kProductionUrlWebsiteTxfb;

  @override
  String get memberShipPaymentUrl => kProductionMemberShip;

  @override
  String get paymentsAccessTokenKey => 'tfb_token';

  @override
  String get unauthenticatedPaymentsUrl =>
      'https://webpayments.billmatrix.com/txfbnonreg';

  @override
  String toString() {
    return 'TfbEnvironmentProduction';
  }
}
