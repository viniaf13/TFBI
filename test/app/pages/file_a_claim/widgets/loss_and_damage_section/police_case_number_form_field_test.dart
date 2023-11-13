import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/police_case_number_form_field.dart';

import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets(
      'Police Case Number form field type valid Police CaseNumber should not show error message',
      (tester) async {
    final policeCaseNumberFieldController = TextEditingController();
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            child: Column(
              children: [
                //Police Case Number Form Field only shows error when out of focus, added another text field to change focus
                TextFormField(),
                PoliceCaseNumberFormField(
                  controller: policeCaseNumberFieldController,
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
      '06850792',
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'c');
    await tester.pumpAndSettle();

    expect(find.text('06850792'), findsOneWidget);
    expect(policeCaseNumberFieldController.text, '06850792');
    expect(
      find.text(AppLocalizationsEn().rangeCharacterCount(25, 2)),
      findsNothing,
    );
  });

  testWidgets(
      'Police Case Number form field type only 1 character should show error message',
      (tester) async {
    final policeCaseNumberFieldController = TextEditingController();
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            child: Column(
              children: [
                //Police Case Number Form Field only shows error when out of focus, added another text field to change focus
                TextFormField(),
                PoliceCaseNumberFormField(
                  controller: policeCaseNumberFieldController,
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
    expect(policeCaseNumberFieldController.text, 'D');
    expect(
      find.text(AppLocalizationsEn().rangeCharacterCount(25, 2)),
      findsOneWidget,
    );
  });

  testWidgets(
      'Police Case Number form field type more than 25 characters should not allow more than 25',
      (tester) async {
    final policeCaseNumberFieldController = TextEditingController();
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            child: Column(
              children: [
                PoliceCaseNumberFormField(
                  controller: policeCaseNumberFieldController,
                  onChanged: (_) => {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
    const textLargerThanMax = 'ThisTextIsLargerThanTheMaximum25';
    await tester.enterText(find.byType(TextFormField), textLargerThanMax);
    await tester.pumpAndSettle();
    expect(find.text(textLargerThanMax), findsNothing);
    expect(policeCaseNumberFieldController.text, '');
  });
}
