import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/begin_claim_event.dart';

void main() {
  test('BeginClaimEvent should have correct properties', () {
    const policyType = 'Life Insurance';
    const policyNumber = '12345';
    const dateOfLoss = '2023-10-13';
    const screenName = 'ClaimScreen';

    final beginClaimEvent = BeginClaimEvent(
      policyType: policyType,
      policyNumber: policyNumber,
      dateOfLoss: dateOfLoss,
      screenName: screenName,
    );

    expect(beginClaimEvent.properties['policy_type'], policyType);
    expect(beginClaimEvent.properties['policy_number'], policyNumber);
    expect(beginClaimEvent.properties['date_of_loss'], dateOfLoss);
    expect(beginClaimEvent.properties['screen_name'], screenName);
    expect(beginClaimEvent.properties['cta'], kBeginClaimCta);
  });
}
