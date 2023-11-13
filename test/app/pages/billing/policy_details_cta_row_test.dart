import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/shared/widgets/policy_details_cta_row.dart';

import '../../../mocks/mock_policy_lookup_client.dart';
import '../../../widgets/tfb_widget_tester.dart';

void main() {
  const manageAutoPayText = 'Manage AutoPay';
  const makePaymentText = 'Make a payment';
  const viewCurrentBillText = 'View current bill';

  testWidgets(
      'BillingDetailsCtaRow shows "Manage AutoPay" button when isEnrolled is true',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: PolicyDetailsCtaRow(
          policySummary: MockPolicy.createPolicySummary(),
        ),
      ),
    );

    expect(find.text(manageAutoPayText), findsOneWidget);
    expect(find.text(makePaymentText), findsNothing);
    expect(find.text(viewCurrentBillText), findsOneWidget);
  });

  testWidgets(
      'BillingDetailsCtaRow shows "Make Payment" button when isEnrolled is false',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: PolicyDetailsCtaRow(
          policySummary: MockPolicy.makeAPaymentPolicy(),
        ),
      ),
    );

    expect(find.text(manageAutoPayText), findsNothing);
    expect(find.text(makePaymentText), findsOneWidget);
    expect(find.text(viewCurrentBillText), findsOneWidget);
  });
}
