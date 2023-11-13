import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/police_department_form_field.dart';

import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets(
      'Police Department form field type valid Police Department should not show error message',
      (tester) async {
    final policeDepartmentFieldController = TextEditingController();
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            child: Column(
              children: [
                //Police Department Form Field only shows error when out of focus, added another text field to change focus
                TextFormField(),
                PoliceDepartmentFormField(
                  controller: policeDepartmentFieldController,
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
      'Dallas Police Deparment',
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'c');
    await tester.pumpAndSettle();

    expect(find.text('Dallas Police Deparment'), findsOneWidget);
    expect(policeDepartmentFieldController.text, 'Dallas Police Deparment');
    expect(
      find.text(AppLocalizationsEn().rangeCharacterCount(40, 2)),
      findsNothing,
    );
  });

  testWidgets(
      'Police Department form field type only 1 character should show error message',
      (tester) async {
    final policeDepartmentFieldController = TextEditingController();
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            child: Column(
              children: [
                //Police Department Form Field only shows error when out of focus, added another text field to change focus
                TextFormField(),
                PoliceDepartmentFormField(
                  controller: policeDepartmentFieldController,
                  onChanged: (_) => {},
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField).at(1), 'D');
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'c');
    await tester.pumpAndSettle();
    expect(find.text('D'), findsOneWidget);
    expect(policeDepartmentFieldController.text, 'D');
    expect(
      find.text(AppLocalizationsEn().rangeCharacterCount(40, 2)),
      findsOneWidget,
    );
  });

  testWidgets(
      'Police Department form field type more than 40 characters should not allow more than 40',
      (tester) async {
    final policeDepartmentFieldController = TextEditingController();
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            child: Column(
              children: [
                PoliceDepartmentFormField(
                  controller: policeDepartmentFieldController,
                  onChanged: (_) => {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
    const textLargerThanMax =
        'ThisTextIsLargerThanTheMaximum40AllowedByTheValidation';
    await tester.enterText(find.byType(TextFormField), textLargerThanMax);
    await tester.pumpAndSettle();
    expect(find.text(textLargerThanMax), findsNothing);
    expect(policeDepartmentFieldController.text, '');
  });
}
