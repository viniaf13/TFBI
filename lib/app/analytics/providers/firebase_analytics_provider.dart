import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';

class FirebaseAnalyticsProvider extends AnalyticsProvider {
  late final FirebaseApp firebaseApp;
  @override
  Future<void> disableTracking() {
    return firebaseApp.setAutomaticDataCollectionEnabled(false);
  }

  Future<void> enableTracking() {
    return firebaseApp.setAutomaticDataCollectionEnabled(true);
  }

  @override
  Future<void> init(config) async {
    final options = config as FirebaseOptions;
    firebaseApp = await Firebase.initializeApp(
      options: options,
    );
    await enableTracking();
  }

  @override
  Future<void> logEvent(AnalyticsEvent event) {
    // Firebase logs events only if the value is less than 100 characters long
    final Map<String, dynamic> parameters = event.toJson().map((key, value) {
      if (value is String) {
        return MapEntry(
          key,
          value.toString().length > 100
              ? '${value.toString().substring(0, 97)}...'
              : value.toString(),
        );
      }
      return MapEntry(key, value);
    });

    return FirebaseAnalytics.instance
        .logEvent(name: event.name, parameters: parameters);
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
  }) async {
    if (userId != null) {
      await FirebaseAnalytics.instance.setUserId(id: userId);
    }
    for (final String key in userProperties.keys) {
      await FirebaseAnalytics.instance
          .setUserProperty(name: key, value: userProperties[key]);
    }
  }
}
