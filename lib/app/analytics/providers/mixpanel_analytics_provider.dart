import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/analytics/tfb_analytics_user_properties.dart';

class MixpanelAnalyticsProvider extends AnalyticsProvider {
  late final Mixpanel mixpanel;
  @override
  Future<void> disableTracking() {
    mixpanel.optOutTracking();
    return Future<void>.value();
  }

  Future<void> enableTracking() {
    mixpanel.optInTracking();
    return Future<void>.value();
  }

  @override
  Future<void> init(config) async {
    final token = config as String;
    mixpanel = await Mixpanel.init(token, trackAutomaticEvents: true);
  }

  @override
  Future<void> logEvent(AnalyticsEvent event) {
    mixpanel.track(event.name, properties: event.toJson());
    return Future<void>.value();
  }

  @override
  Future<void> update(localFields) {
    final properties = localFields as TfbAnalyticsUserProperties;
    return identify(
      userId: properties.userId,
      userProperties: properties.properties,
    );
  }

  Future<void> identify({
    String? userId,
    Map<String, String> userProperties = const {},
  }) {
    if (userId != null) {
      mixpanel.identify(userId);
    }
    if (userProperties.isNotEmpty) {
      mixpanel.registerSuperProperties(userProperties);
    }
    return Future<void>.value();
  }
}
