//  Copyright © 2022 Bottle Rocket Studios. All rights reserved.

import 'package:plugin_haven/analytics/analytics.dart';

/// A manager that integrates multiple analytics services into a single
/// provider.
///
/// Applications should add their specific providers to this class and use this
/// class to log events. This abstracts implementations from the specifics of
/// the underlying anaytics implementation.
class AnalyticsManager extends AnalyticsProvider {
  final List<AnalyticsProvider> _providers = [];

  /// Adds an [AnalyticsProvider] to the list of managed providers that should
  /// log events.
  void add(AnalyticsProvider provider) {
    _providers.add(provider);
  }

  /// Logs an [AnalyticsEvent] to each known [AnalyticsProvider].
  @override
  Future<void> logEvent(AnalyticsEvent event) async {
    for (AnalyticsProvider provider in _providers) {
      provider.logEvent(event);
    }
  }

  /// Updates each [AnalyticsProvider] with application specific properties.
  ///
  /// This is intended to be used for global configuration or user properties
  /// that apply to all events.
  ///
  /// Normally called after related services have been configured and/or user
  /// has signed in.
  ///
  /// Example properties may include a push provider key that is integrated
  /// with analytics on the back-end, or a user membership level.
  @override
  Future<void> update(dynamic localFields) async {
    for (AnalyticsProvider provider in _providers) {
      provider.update(localFields);
    }
  }

  /// [AnalyticsProvider] interface. Initialization of specific providers is
  /// application and provider specific so outside the scope of this generic
  /// manager.
  @override
  Future<void> init(config) {
    return Future.value();
  }

  /// [AnalyticsProvider] interface. Tracking should be disabled on each
  /// provider as specified in its documentation. Disabling logging at this
  /// level cannot guarantee that a specific service will not continue some
  /// measure of tracking.
  @override
  Future<void> disableTracking() {
    throw UnsupportedError('Disable tracking on each provider.');
  }
}
