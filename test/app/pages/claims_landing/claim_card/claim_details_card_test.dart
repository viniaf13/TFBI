import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claim_card/claim_details_card.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claim_card/claim_details_card_header.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claim_card/claim_details_content.dart';
import 'package:txfb_insurance_flutter/shared/widgets/expand_card_icon.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claim_card/claim_details_expand_icon_row.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/domain_models/full_claim.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/shared/enum/claim_status_enum.dart';
import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final FullClaim claim = FullClaim(
    policyType: PolicyType.txPersonalAuto,
    statusEnum: ClaimStatusEnum.active,
    claimNumber: '123456',
    policyNumber: '1234567',
    dateOfLoss: '01/01/2023',
    claimDetails: null,
  );

  testWidgets('ClaimDetailsCard builds without error',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(child: ClaimDetailsCard(claim: claim)),
    );

    expect(find.byType(ClaimDetailsCard), findsOneWidget);
  });

  testWidgets(
      'ClaimDetailsCard contains ClaimDetailsCardHeader and ClaimDetailsExpandIconRow widgets',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(child: ClaimDetailsCard(claim: claim)),
    );

    expect(find.byType(ClaimDetailsCardHeader), findsOneWidget);
    expect(find.byType(ClaimDetailsExpandIconRow), findsOneWidget);
  });

  testWidgets(
      'ClaimDetailsCard does not contain ClaimDetailsContent widget initially',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(child: ClaimDetailsCard(claim: claim)),
    );

    expect(find.byType(ClaimDetailsContent), findsNothing);
  });

  testWidgets(
      'ClaimDetailsCard shows ClaimDetailsContent widget when ClaimDetailsExpandIconRow is tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: ClaimDetailsCard(claim: claim),
      ),
    );

    await tester.tap(find.byType(ExpandCardIcon));
    await tester.pumpAndSettle();

    expect(find.byType(ClaimDetailsContent), findsOneWidget);
  });

  testWidgets(
      'ClaimDetailsCard hides ClaimDetailsContent widget when ClaimDetailsExpandIconRow is tapped again',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(child: ClaimDetailsCard(claim: claim)),
    );

    await tester.tap(find.byType(ClaimDetailsExpandIconRow));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ClaimDetailsExpandIconRow));
    await tester.pumpAndSettle();

    expect(find.byType(ClaimDetailsContent), findsNothing);
  });
}
