import 'package:plugin_haven/plugin_haven.dart';

class TfbAnalyticsEvent extends AnalyticsEvent {
  const TfbAnalyticsEvent(this.name, {this.properties = const {}});

  @override
  final String name;

  @override
  final Map<String, dynamic> properties;

  @override
  Map<String, dynamic> toJson() => properties;
}
