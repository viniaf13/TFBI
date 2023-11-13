import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/shared/widgets/policy_details_cta_row.dart';

import '../../../../mocks/mock_policy_lookup_client.dart';
import '../../../../mocks/mock_tfb_navigator.dart';
import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets(
      'PolicyDetailCtaRow displays Manage AutoPay when AutoPay is '
      'enabled', (WidgetTester tester) async {
    final mockPolicy = MockPolicy.createPolicySummary();

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: PolicyDetailsCtaRow(policySummary: mockPolicy),
        ),
      ),
    );

    expect(find.text(AppLocalizationsEn().manageAutoPay), findsOneWidget);
    expect(find.text(AppLocalizationsEn().makePaymentCta), findsNothing);
    expect(find.text(AppLocalizationsEn().viewCurrentBillCta), findsOneWidget);
  });

  testWidgets(
      'PolicyDetailCtaRow displays Make Payment when AutoPay is not'
      'enable', (WidgetTester tester) async {
    final mockPolicy = MockPolicy.makeAPaymentPolicy();

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: PolicyDetailsCtaRow(policySummary: mockPolicy),
        ),
      ),
    );

    expect(find.text(AppLocalizationsEn().manageAutoPay), findsNothing);
    expect(find.text(AppLocalizationsEn().makePaymentCta), findsOneWidget);
    expect(find.text(AppLocalizationsEn().viewCurrentBillCta), findsOneWidget);
  });

  testWidgets(
      'PolicyDetailCtaRow Manage Autopay CTA navigates to autopay enrollment page',
      (WidgetTester tester) async {
    final mockPolicy = MockPolicy.createPolicySummary();
    final mockNavigator = MockTfbNavigator();

    when(() => mockNavigator.pushAutoPayEnrollment(mockPolicy))
        .thenAnswer((_) => Future<Object?>.value());

    await tester.pumpWidget(
      TfbWidgetTester(
        mockNavigator: mockNavigator,
        child: Scaffold(
          body: PolicyDetailsCtaRow(policySummary: mockPolicy),
        ),
      ),
    );

    final manageAutoPayFinder = find.text(AppLocalizationsEn().manageAutoPay);

    expect(manageAutoPayFinder, findsOneWidget);
    expect(find.text(AppLocalizationsEn().makePaymentCta), findsNothing);

    await tester.tap(manageAutoPayFinder);
    await tester.pumpAndSettle();
    verify(() => mockNavigator.pushAutoPayEnrollment(mockPolicy)).called(1);
  });
}
