import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';

class MockAnalyticsProvider extends AnalyticsProvider {
  bool trackingEnabled = true;
  bool isInitialized = false;

  List<AnalyticsEvent> loggedEvents = [];
  TfbAnalyticsUserProperties? properties;

  @override
  Future<void> disableTracking() {
    trackingEnabled = false;
    return Future.value();
  }

  @override
  Future<void> init(config) {
    isInitialized = true;
    return Future.value();
  }

  @override
  Future<void> logEvent(AnalyticsEvent event) {
    loggedEvents.add(event);
    return Future.value();
  }

  @override
  Future<void> update(localFields) {
    properties = localFields as TfbAnalyticsUserProperties;
    return Future.value();
  }
}
