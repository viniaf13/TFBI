import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class TfbAnalyticsUserProperties {
  const TfbAnalyticsUserProperties({
    required this.userId,
    this.properties = const {},
  });

  factory TfbAnalyticsUserProperties.fromUser(TfbUser user) =>
      TfbAnalyticsUserProperties(
        userId: user.members!.first.memberNumber,
      );

  final String userId;
  final Map<String, String> properties;
}
