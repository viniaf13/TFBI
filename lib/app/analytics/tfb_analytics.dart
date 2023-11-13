import 'package:firebase_core/firebase_core.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/session_analytics_events.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/tfb_analytics_event.dart';
import 'package:txfb_insurance_flutter/app/analytics/providers/firebase_analytics_provider.dart';
import 'package:txfb_insurance_flutter/app/analytics/providers/mixpanel_analytics_provider.dart';
import 'package:txfb_insurance_flutter/app/analytics/tfb_analytics_user_properties.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class TfbAnalyticsConfig {
  const TfbAnalyticsConfig({
    this.firebaseOptions,
    this.mixpanelToken,
  });

  final FirebaseOptions? firebaseOptions;
  final String? mixpanelToken;
}

/// TFBI implementation of [AnalyticsManager]
///
/// All analytics events should be triggered through this class instance.
/// Application code should avoid direct use of [FirebaseAnalyticsProvider] or
/// [MixpanelAnalyticsProvider].
///
/// This class will propagate all events to both.
class TfbAnalytics extends AnalyticsManager {
  TfbAnalytics._();

  static TfbAnalytics instance = TfbAnalytics._();

  Future<void> configure(TfbAnalyticsConfig? config) {
    return init(
      config ?? const TfbAnalyticsConfig(),
    );
  }

  @override
  Future<void> init(dynamic config) async {
    final options = config as TfbAnalyticsConfig;
    if (options.firebaseOptions != null) {
      final firebase = FirebaseAnalyticsProvider();
      await firebase.init(options.firebaseOptions);
      add(firebase);
    }
    if (!options.mixpanelToken.isNullOrEmpty) {
      final mixpanel = MixpanelAnalyticsProvider();
      await mixpanel.init(options.mixpanelToken);
      add(mixpanel);
    }
    if (HavenApp.isFirstRun) {
      track(const AppFirstOpen());
    }
  }

  Future<void> track(TfbAnalyticsEvent event) {
    return logEvent(event);
  }

  Future<void> identify(TfbUser user) {
    return update(TfbAnalyticsUserProperties.fromUser(user));
  }
}
