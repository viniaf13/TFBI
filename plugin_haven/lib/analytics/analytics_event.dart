//  Copyright © 2022 Bottle Rocket Studios. All rights reserved.

/// Abstract interface for all analytics events.
abstract class AnalyticsEvent {
  const AnalyticsEvent();

  /// Event name
  String get name;

  /// Event properties - may be provider specific
  dynamic get properties;

  /// Event properties as JSON
  Map<String, dynamic> toJson();
}
