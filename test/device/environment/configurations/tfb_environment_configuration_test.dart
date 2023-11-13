import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/device/environment/configurations/tfb_environment_configuration.dart';

class MockTfbEnvironmentConfiguration extends TfbEnvironmentConfiguration {
  @override
  String get apiBaseUrl => 'test_api_base_url';

  @override
  ThemeData? get lightThemeData => ThemeData();
}

void main() {
  group('TfbEnvironmentConfiguration', () {
    test('Check onChangeEnvironment', () {
      final mockTfbEnvironmentConfiguration = MockTfbEnvironmentConfiguration();
      expect(mockTfbEnvironmentConfiguration.onChangeEnvironment, isNotNull);
    });

    test('Check toString method', () {
      final mockTfbEnvironmentConfiguration = MockTfbEnvironmentConfiguration();
      expect(
        mockTfbEnvironmentConfiguration.toString(),
        'TfbEnvironmentConfiguration(apiBaseUrl: test_api_base_url, usePreview: false)',
      );
    });
  });
}
