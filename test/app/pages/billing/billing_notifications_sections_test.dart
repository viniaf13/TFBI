import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/paperless_billing/billing_notifications_section.dart';

import '../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('section title displays', (WidgetTester tester) async {
    const sectionTitle = 'Test Section';
    const widget = BillingNotificationsSection(
      sectionTitle: sectionTitle,
      infoSection: null,
    );
    await tester.pumpWidget(
      const TfbWidgetTester(
        child: widget,
      ),
    );
    expect(find.text(sectionTitle), findsOneWidget);
  });

  testWidgets('enabled status displays', (WidgetTester tester) async {
    const sectionTitle = 'Test Section';
    const widget = BillingNotificationsSection(
      sectionTitle: sectionTitle,
      infoSection: null,
    );

    await tester.pumpWidget(
      const TfbWidgetTester(
        child: widget,
      ),
    );
    expect(find.text('Enabled'), findsOneWidget);
  });

  testWidgets('disabled status displays', (WidgetTester tester) async {
    const sectionTitle = 'Test Section';
    final widget = BillingNotificationsSection.disabled(sectionTitle);
    await tester.pumpWidget(
      TfbWidgetTester(
        child: widget,
      ),
    );
    expect(find.text('Disabled'), findsOneWidget);
  });

  testWidgets('info section displays when enabled',
      (WidgetTester tester) async {
    const sectionTitle = 'Test Section';
    const infoSection = Text('Info text');
    const widget = BillingNotificationsSection(
      sectionTitle: sectionTitle,
      infoSection: infoSection,
    );
    await tester.pumpWidget(
      const TfbWidgetTester(
        child: widget,
      ),
    );
    expect(find.text('Info text'), findsOneWidget);
  });

  testWidgets('info section does not display when disabled',
      (WidgetTester tester) async {
    const sectionTitle = 'Test Section';
    final widget = BillingNotificationsSection.disabled(sectionTitle);

    await tester.pumpWidget(
      TfbWidgetTester(
        child: widget,
      ),
    );
    expect(find.text('Send to'), findsNothing);
  });

  testWidgets('text uses correct styles', (WidgetTester tester) async {
    final sectionTitleFinder = find.byWidgetPredicate(
      (widget) => widget is Text && widget.data == 'Section Title',
    );
    const sectionTitle = 'Section Title';
    const widget = BillingNotificationsSection(
      sectionTitle: sectionTitle,
      infoSection: null,
    );
    await tester.pumpWidget(
      const TfbWidgetTester(
        child: widget,
      ),
    );
    expect(sectionTitleFinder, findsOneWidget);
  });
}
