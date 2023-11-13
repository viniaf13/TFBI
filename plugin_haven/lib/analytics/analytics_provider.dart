//  Copyright © 2022 Bottle Rocket Studios. All rights reserved.

import 'package:plugin_haven/analytics/analytics.dart';

/// Interface for analytics services so analytics can be provided
/// by the [AnalyticsManager].
abstract class AnalyticsProvider {
  /// Service provider specific initialization. Called before logging any
  /// events.
  Future<void> init(dynamic config);

  /// Sets common properties such as user attributes or service integrations
  Future<void> update(dynamic localFields);

  /// Logs an analytics event
  Future<void> logEvent(AnalyticsEvent event);

  /// Disables tracking
  Future<void> disableTracking();
}
