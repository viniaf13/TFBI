// coverage:ignore-file
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';
import 'package:txfb_insurance_flutter/domain/models/app_info/enums/web_uri_enums.dart';

abstract class TfbEnvironment extends Environment {
  String get apiUrl;
  String get websiteUrl;
  String get memberShipPaymentUrl;

  /// Environment specific payment configuration
  String get paymentsAccessTokenKey;

  String get unauthenticatedPaymentsUrl;

  Uri createPaymentUri(PolicyType policyType, String policyNumber) =>
      Uri.parse('$websiteUrl/payments/${policyType.value}/$policyNumber');

  String createWebsiteUri(WebUriEnum uri) => '$websiteUrl/${uri.path}';
}
