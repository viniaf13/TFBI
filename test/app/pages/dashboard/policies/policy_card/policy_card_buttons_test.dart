import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/policies/policy_card/policy_card_buttons.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';

import '../../../../../mocks/mock_policy_lookup_client.dart';
import '../../../../../mocks/mock_tfb_navigator.dart';
import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  setUp(() {});

  testWidgets(
    "Should display 'Manage AutoPay' and 'Policy Overview' "
    'buttons Policy Card',
    (WidgetTester tester) async {
      await testPolicyCardButtons(
        tester,
        expectedButtonText: AppLocalizationsEn().manageAutoPay,
        minimumAmountDue: '100',
      );
    },
  );

  testWidgets(
    "Should display 'Make a Payment' and 'Policy Overview' "
    'buttons Policy Card',
    (WidgetTester tester) async {
      await testPolicyCardButtons(
        tester,
        expectedButtonText: AppLocalizationsEn().makePaymentCta,
        isAutoPay: false,
        minimumAmountDue: '100',
      );
    },
  );

  testWidgets(
    "Should display only 'Policy Overview' "
    'button on Policy Card',
    (WidgetTester tester) async {
      await testPolicyCardButtons(
        tester,
        expectedButtonText: AppLocalizationsEn().manageAutoPay,
        matcher: findsNothing,
      );

      await testPolicyCardButtons(
        tester,
        expectedButtonText: AppLocalizationsEn().manageAutoPay,
        matcher: findsNothing,
        isAutoPay: false,
      );
    },
  );

  testWidgets('Manage Autopay CTA navigates to autopay enrollment page',
      (WidgetTester tester) async {
    final mockPolicySummary = MockPolicy.createPolicySummary();
    final mockNavigator = MockTfbNavigator();

    when(() => mockNavigator.pushAutoPayEnrollment(mockPolicySummary))
        .thenAnswer((_) => Future<Object?>.value());

    await tester.pumpWidget(
      TfbWidgetTester(
        mockNavigator: mockNavigator,
        child: PolicyCardButtons(
          summary: mockPolicySummary,
        ),
      ),
    );

    final manageAutoPayFinder = find.text(AppLocalizationsEn().manageAutoPay);

    expect(manageAutoPayFinder, findsOneWidget);
    expect(find.text(AppLocalizationsEn().makePaymentCta), findsNothing);

    await tester.tap(manageAutoPayFinder);
    await tester.pumpAndSettle();
    verify(() => mockNavigator.pushAutoPayEnrollment(mockPolicySummary))
        .called(1);
  });
}

Future<void> testPolicyCardButtons(
  WidgetTester tester, {
  required String expectedButtonText,
  Matcher matcher = findsOneWidget,
  String minimumAmountDue = '0',
  bool isAutoPay = true,
}) async {
  late PolicySummary mockPolicySummary;
  if (isAutoPay) {
    mockPolicySummary = MockPolicy.createPolicySummary(
      policyMinimumAmountDue: minimumAmountDue,
    );
  } else {
    mockPolicySummary = MockPolicy.makeAPaymentPolicy();
  }

  await tester.pumpWidget(
    TfbWidgetTester(
      child: PolicyCardButtons(
        summary: mockPolicySummary,
      ),
    ),
  );

  expect(find.text(expectedButtonText), matcher);
  expect(find.text(AppLocalizationsEn().policyOverviewCta), findsOneWidget);
}
