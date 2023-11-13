import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/shared/enum/claim_status_enum.dart';

import '../../app/pages/policy_detail/widgets/insurance_card_content_test.dart';

void main() {
  test('ClaimStatusEnum should have correct values', () {
    const activeStatus = ClaimStatusEnum.active;
    const inactiveStatus = ClaimStatusEnum.inactive;
    const undefinedStatus = ClaimStatusEnum.undefinedClaimStatus;

    expect(activeStatus.value, 'OPEN');
    expect(inactiveStatus.value, 'CLOSED');
    expect(undefinedStatus.value, 'UNDEFINED');
  });

  test(
      'ClaimStatusEnum name method should return correct '
      'localized string', () {
    final context = MockBuildContext();

    const activeStatus = ClaimStatusEnum.active;
    const inactiveStatus = ClaimStatusEnum.inactive;
    const undefinedStatus = ClaimStatusEnum.undefinedClaimStatus;

    expect(
      activeStatus.name(context),
      AppLocalizationsEn().claimsActive,
    );
    expect(
      inactiveStatus.name(context),
      AppLocalizationsEn().claimsClosed,
    );
    expect(
      undefinedStatus.name(context),
      AppLocalizationsEn().undefinedClaimStatus,
    );
  });
}
