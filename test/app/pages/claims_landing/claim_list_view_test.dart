import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claim_card/claim_details_claims_section.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claim_list_view.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/domain_models/full_claim.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/shared/enum/claim_status_enum.dart';

import '../../../widgets/tfb_widget_tester.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final List<FullClaim?> claims = [
    FullClaim(
      claimNumber: '123456',
      policyNumber: '1234567',
      policyType: PolicyType.homeowners,
      dateOfLoss: '01/12/2022',
      statusEnum: ClaimStatusEnum.active,
      claimDetails: null,
    ),
    FullClaim(
      claimNumber: '123456',
      policyNumber: '1234567',
      policyType: PolicyType.txPersonalAuto,
      dateOfLoss: '01/12/2022',
      statusEnum: ClaimStatusEnum.inactive,
      claimDetails: null,
    ),
    null,
  ];

  testWidgets('ClaimListView builds without error',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: ClaimListView(claims),
      ),
    );

    expect(find.byType(ClaimListView), findsOneWidget);
  });

  testWidgets('ClaimListView contains two ClaimDetailsClaimsSection widgets',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: ClaimListView(claims),
      ),
    );

    expect(find.byType(ClaimDetailsClaimsSection), findsNWidgets(2));
  });

  testWidgets('ClaimDetailsClaimsSections receive partitioned claims',
      (WidgetTester tester) async {
    final nonNullClaims = claims.where((c) => c != null).toList();

    await tester.pumpWidget(
      TfbWidgetTester(
        child: ClaimListView(nonNullClaims),
      ),
    );

    final sections = tester.widgetList<ClaimDetailsClaimsSection>(
      find.byType(ClaimDetailsClaimsSection),
    );

    expect(
      sections.first.claims,
      orderedEquals(
        claims.where((c) => c?.statusEnum == ClaimStatusEnum.active),
      ),
    );
    expect(
      sections.last.claims,
      orderedEquals(
        claims.where((c) => c?.statusEnum == ClaimStatusEnum.inactive),
      ),
    );
  });
}
