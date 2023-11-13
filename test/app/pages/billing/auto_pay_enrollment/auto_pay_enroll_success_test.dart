import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/auto_pay_enrollment/auto_pay_enrollment_success_page.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/shared/widgets/gradient_background.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_filled_button.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_never_pop.dart';

import '../../../../widgets/tfb_widget_tester.dart';

class MockPolicySummary extends Mock implements PolicySummary {}

class FakeInvocation extends Fake implements Invocation {}

void main() {
  group('AutoPayEnrollmentSuccessPage', () {
    late PolicySummary mockPolicy;

    setUp(() {
      mockPolicy = MockPolicySummary();
      when(() => mockPolicy.isAutoPayEnabled).thenReturn(false);
    });

    setUpAll(() => registerFallbackValue(FakeInvocation()));

    testWidgets('renders TfbNeverPop', (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: AutoPayEnrollmentSuccessPage(policy: mockPolicy),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(TfbNeverPop), findsOneWidget);
    });

    testWidgets('renders gradient background', (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: AutoPayEnrollmentSuccessPage(policy: mockPolicy),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(GradientBackground), findsOneWidget);
    });

    testWidgets('renders pinned button', (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: AutoPayEnrollmentSuccessPage(policy: mockPolicy),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(TfbFilledButton), findsOneWidget);
    });

    testWidgets('renders success text', (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: AutoPayEnrollmentSuccessPage(policy: mockPolicy),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Success!'), findsOneWidget);
    });

    testWidgets('renders success check image', (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: AutoPayEnrollmentSuccessPage(policy: mockPolicy),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.bySemanticsLabel('Success image'), findsWidgets);
    });
  });
}
