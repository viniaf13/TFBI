import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claims_section_header_view.dart';
import 'package:txfb_insurance_flutter/shared/enum/claim_status_enum.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/domain_models/full_claim.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/claim_details/claim_details.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claim_list_view.dart';
import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  final List<FullClaim> emptyClaims = [];
  final List<FullClaim> activeClaims = [
    FullClaim(
      claimNumber: '123',
      statusEnum: ClaimStatusEnum.active,
      policyNumber: '456',
      policyType: PolicyType.txPersonalAuto,
      dateOfLoss: 'not a real date',
      claimDetails: ClaimDetails(),
    ),
  ];
  final List<FullClaim> closedClaims = [
    FullClaim(
      claimNumber: '123',
      statusEnum: ClaimStatusEnum.inactive,
      policyNumber: '456',
      policyType: PolicyType.txPersonalAuto,
      dateOfLoss: 'not a real date',
      claimDetails: ClaimDetails(),
    ),
  ];
  testWidgets('List should have an active section',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: ClaimListView(activeClaims),
      ),
    );

    expect(find.byType(ClaimsSectionHeaderView), findsOneWidget);
  });

  /// Active claims ///
  testWidgets('List should have an closed section',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: ClaimListView(closedClaims),
      ),
    );

    expect(find.byType(ClaimsSectionHeaderView), findsOneWidget);
  });

  /// Active claims ///
  testWidgets('Claims should be empty', (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: ClaimListView(emptyClaims),
      ),
    );

    expect(find.byType(ClaimsSectionHeaderView), findsNothing);
  });
}
