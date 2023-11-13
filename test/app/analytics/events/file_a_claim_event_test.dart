import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/file_claim_event.dart';

void main() {
  test('FileAClaimEvent should have correct properties', () {
    const screenName = 'ClaimScreen';

    final fileAClaimEvent = FileAClaimEvent(screenName);

    expect(fileAClaimEvent.properties['screen_name'], screenName);
    expect(fileAClaimEvent.properties['cta'], 'File a claim');
  });
}
