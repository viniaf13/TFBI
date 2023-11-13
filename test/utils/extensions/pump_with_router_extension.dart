import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:plugin_haven/environment/environment_provider.dart';
import 'package:txfb_insurance_flutter/resources/theme/themes/tfb_typography.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

extension PumpWithRouter on WidgetTester {
  Future<void> pumpWithRouter(
    GoRouter router, {
    Widget Function(Widget child)? builder,
  }) {
    final child = EnvironmentProvider(
      defaultEnvironment: TfbEnvironmentDev(),
      child: MaterialApp.router(
        theme: ThemeData(extensions: const [TfbTypography()]),
        routerConfig: router,
      ),
    );

    if (builder == null) return pumpWidget(child);

    return pumpWidget(
      builder(child),
    );
  }
}
