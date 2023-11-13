import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/policies/policy_card/policy_payment_label.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

import '../../../../../mocks/mock_policy_lookup_client.dart';
import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  Widget wrapWithProviders(Widget child) {
    return TfbWidgetTester(
      child: child,
    );
  }

  group('PolicyPaymentLabel Widget', () {
    late PolicySummary policySummary;

    setUp(() {
      policySummary = MockPolicy.createPolicySummary(
        policyType: PolicyType.txPersonalAuto,
        policyNumber: '123',
      );
    });

    testWidgets(
        'Should show "No payments due" text when state is PaymentsSuccess and accountBillResponse is empty',
        (WidgetTester tester) async {
      policySummary =
          MockPolicy.createPolicySummary(policyMinimumAmountDue: '0');

      await tester.pumpWidget(
        wrapWithProviders(
          PolicyPaymentLabel(
            policySummary: policySummary,
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.textContaining('No payments due'), findsOneWidget);
    });

    testWidgets('Should show "The next payment" text ',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithProviders(
          PolicyPaymentLabel(
            policySummary: policySummary,
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.textContaining('payment'), findsOneWidget);
    });
  });
}
