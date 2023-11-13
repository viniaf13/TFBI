import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/yesno_button.dart';
import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('yesno button should have yes text when enum is set to yes.',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: YesNoButton(
          value: true,
          kind: YesNoButtonKind.yes,
          onTap: () {},
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.byType(YesNoButton),
      findsOneWidget,
    );
    expect(
      find.text('Yes'),
      findsOneWidget,
    );
  });
  testWidgets('yesno button should have no text when enum is set to no.',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: YesNoButton(
          value: true,
          kind: YesNoButtonKind.no,
          onTap: () {},
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.byType(YesNoButton),
      findsOneWidget,
    );
    expect(
      find.text('No'),
      findsOneWidget,
    );
  });
  testWidgets('yesno button should show a check when the value is true',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: YesNoButton(
          value: true,
          kind: YesNoButtonKind.no,
          onTap: () {},
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.byType(YesNoButton),
      findsOneWidget,
    );
    expect(
      find.byType(Image),
      findsOneWidget,
    );
  });
  testWidgets('yesno button should not show a check when the value is false',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: YesNoButton(
          value: false,
          kind: YesNoButtonKind.no,
          onTap: () {},
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.byType(YesNoButton),
      findsOneWidget,
    );
    expect(
      find.byType(Image),
      findsNothing,
    );
  });
}
