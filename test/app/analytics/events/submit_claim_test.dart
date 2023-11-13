import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/submit_claim.dart';

void main() {
  test('SubmitClaim should have correct event name and properties', () {
    const policyType = 'Life Insurance';
    const policyNumber = '12345';
    const dateOfLoss = '2023-10-13';
    const timeOfLoss = '12:34 PM';
    const screenName = 'SubmitClaimScreen';

    final submitClaimEvent = SubmitClaim(
      policyType: policyType,
      policyNumber: policyNumber,
      dateOfLoss: dateOfLoss,
      timeOfLoss: timeOfLoss,
      screenName: screenName,
    );

    expect(submitClaimEvent.properties['policy_type'], policyType);
    expect(submitClaimEvent.properties['policy_number'], policyNumber);
    expect(submitClaimEvent.properties['date_of_loss'], dateOfLoss);
    expect(submitClaimEvent.properties['time_of_loss'], timeOfLoss);
    expect(submitClaimEvent.properties['screen_name'], screenName);
    expect(submitClaimEvent.properties['cta'], kCtaName);
  });
}
