// coverage:ignore-file
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment.dart';

class TfbEnvironmentQA extends TfbEnvironment {
  @override
  String get apiUrl => kQaApiBaseUrl;

  @override
  String get websiteUrl => kQAUrlWebsiteTxfb;

  @override
  String get memberShipPaymentUrl => kTestMemberShip;

  @override
  String get paymentsAccessTokenKey => 'tfb_STG_token';

  @override
  String get unauthenticatedPaymentsUrl =>
      'https://odweb.clienttestmatrix.com/txfbnonreg';

  @override
  String toString() {
    return 'TfbEnvironmentQa';
  }
}
