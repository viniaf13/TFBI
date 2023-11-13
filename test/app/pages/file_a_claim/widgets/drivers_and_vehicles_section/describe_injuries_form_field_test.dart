import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/describe_injuries_form_field.dart';

import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets(
      'describe injuries form field type valid description, should not show error message',
      (tester) async {
    final describeInjuriesFieldController = TextEditingController();

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            child: Column(
              children: [
                //Validating Form Field only shows error when out of focus, added another text field to change focus
                TextFormField(),
                DescribeInjuriesFormField(
                  controller: describeInjuriesFieldController,
                  onChanged: (_) => {},
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Injuries description',
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'c');
    await tester.pumpAndSettle();

    expect(find.text('Injuries description'), findsOneWidget);
    expect(describeInjuriesFieldController.text, 'Injuries description');
    expect(
      find.text(AppLocalizationsEn().rangeCharacterCount(50, 2)),
      findsNothing,
    );
  });

  testWidgets(
      'describe injuries form field type invalid description, should show error message',
      (tester) async {
    final describeInjuriesFieldController = TextEditingController();

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            child: Column(
              children: [
                //Validating Form Field only shows error when out of focus, added another text field to change focus
                TextFormField(),
                DescribeInjuriesFormField(
                  controller: describeInjuriesFieldController,
                  onChanged: (_) => {},
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.enterText(
      find.byType(TextFormField).at(1),
      'a',
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'c');
    await tester.pumpAndSettle();

    expect(find.text('a'), findsOneWidget);
    expect(describeInjuriesFieldController.text, 'a');
    expect(
      find.text(AppLocalizationsEn().rangeCharacterCount(50, 3)),
      findsOneWidget,
    );
  });
}
