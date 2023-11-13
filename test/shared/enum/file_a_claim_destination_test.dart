import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/shared/enum/file_a_claim_destination.dart';

void main() {
  test('FileAClaimDestination should have correct values', () {
    const claimStar = FileAClaimDestination.claimStar;
    const legacy = FileAClaimDestination.legacy;

    expect(claimStar.value, 0);
    expect(claimStar.name, 'CLAIMSTAR');
    expect(claimStar.numberValue, 0);
    expect(claimStar.numberName, 'CLAIMSTAR');
    expect(claimStar.toString(), 'CLAIMSTAR');

    expect(legacy.value, 1);
    expect(legacy.name, 'LEGACY');
    expect(legacy.numberValue, 1);
    expect(legacy.numberName, 'LEGACY');
    expect(legacy.toString(), 'LEGACY');
  });
}
