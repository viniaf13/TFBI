// coverage:ignore-file
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/analytics/tfb_analytics.dart';
import 'package:txfb_insurance_flutter/data/network/clients/tfb_non_authenticate_client.dart';
import 'package:txfb_insurance_flutter/shared/utils/tfb_logger.dart';

class TfbEnvironmentConfiguration extends EnvironmentConfiguration {
  TfbEnvironmentConfiguration({this.analyticsConfig});

  late String apiBaseUrl;
  late ThemeData? lightThemeData;
  final Dio _privateDio = TfbNonAuthenticateClient.instance.client;

  TfbAnalyticsConfig? analyticsConfig;

  @override
  FutureOr<void> Function()? get onChangeEnvironment => () {
        TfbLogger.verbose('Switching to environment', this);
      };

  @override
  String toString() =>
      'TfbEnvironmentConfiguration(apiBaseUrl: $apiBaseUrl, usePreview: $usePreview)';

  Dio get unauthenticatedDio => _privateDio;
}
