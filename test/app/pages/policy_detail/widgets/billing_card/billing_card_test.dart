import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/billing_card/billing_card.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../../../../mocks/mock_policy_lookup_client.dart';
import '../../../../../widgets/tfb_widget_tester.dart';

class MockPolicyBilling extends Mock implements PolicyBilling {}

void main() {
  late PolicyBilling mockPolicyBilling;
  late PolicySummary mockPolicySummary;

  setUp(() {
    mockPolicyBilling = MockPolicyBilling();
    mockPolicySummary = MockPolicy.createPolicySummary();
  });

  Widget buildBillingCard(PolicyBilling policyBilling) {
    return TfbWidgetTester(
      child: Scaffold(
        body: BillingCard(
          policyBilling: policyBilling,
          policySummary: mockPolicySummary,
        ),
      ),
    );
  }

  testWidgets('BillingCard displays header content', (tester) async {
    const billingTitle = 'Billing';
    const paymentHistory = 'Payment history';
    const billingDocuments = 'Billing documents';

    when(() => mockPolicyBilling.mapPremiumForCurrentPolicy).thenReturn({
      'Label 1': 'Value 1',
      'Label 2': 'Value 2',
    });

    await tester.pumpWidget(buildBillingCard(mockPolicyBilling));

    expect(find.text(billingTitle), findsOneWidget);
    expect(find.text(paymentHistory), findsOneWidget);
    expect(find.text(billingDocuments), findsOneWidget);
  });

  testWidgets('BillingCard displays expandable section label', (tester) async {
    const detailsLabel = 'Details';

    when(() => mockPolicyBilling.mapPremiumForCurrentPolicy).thenReturn({
      'Label 1': 'Value 1',
      'Label 2': 'Value 2',
    });

    await tester.pumpWidget(buildBillingCard(mockPolicyBilling));

    expect(find.text(detailsLabel), findsOneWidget);
  });
}
