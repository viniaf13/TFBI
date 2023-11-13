import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/auto_pay_enrollment/auto_pay_enrollment_success_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import '../../../../widgets/tfb_widget_tester.dart';
import '../../policy_detail/widgets/insurance_card_content_test.dart';

void main() {
  testWidgets(
      'Auto pay enrollment success page shows correct message when configuring autopay for the first time',
      (tester) async {
    final mockPolicySummary = MockPolicySummary();
    when(() => mockPolicySummary.isAutoPayEnabled).thenReturn(false);

    await tester.pumpWidget(
      TfbWidgetTester(
        child: AutoPayEnrollmentSuccessPage(
          policy: mockPolicySummary,
        ),
      ),
    );

    expect(
      find.text(AppLocalizationsEn().autoPayEnrollSuccessMessage),
      findsOneWidget,
    );
  });

  testWidgets(
      'Autopay enrollment success page shows manage autopay success message when autopay is already configured',
      (tester) async {
    final mockPolicySummary = MockPolicySummary();
    when(() => mockPolicySummary.isAutoPayEnabled).thenReturn(true);

    await tester.pumpWidget(
      TfbWidgetTester(
        child: AutoPayEnrollmentSuccessPage(
          policy: mockPolicySummary,
        ),
      ),
    );

    expect(
      find.text(AppLocalizationsEn().autoPayManageSuccessMessage),
      findsOneWidget,
    );
  });
}
