import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/reporter_info_section/name_form_field.dart';

import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('Name form field type valid name should not show error message',
      (tester) async {
    final nameFieldController = TextEditingController();

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            child: Column(
              children: [
                //Name Form Field only shows error when out of focus, added another text field to change focus
                TextFormField(),
                NameFormField(
                  controller: nameFieldController,
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
      'John Doe',
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'c');
    await tester.pumpAndSettle();

    expect(find.text('John Doe'), findsOneWidget);
    expect(nameFieldController.text, 'John Doe');
    expect(
      find.text(AppLocalizationsEn().rangeCharacterCount(60, 2)),
      findsNothing,
    );
  });

  testWidgets('Name form field type invalid name should show error message',
      (tester) async {
    final nameFieldController = TextEditingController();

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            child: Column(
              children: [
                //Name Form Field only shows error when out of focus, added another text field to change focus
                TextFormField(),
                NameFormField(
                  controller: nameFieldController,
                  onChanged: (_) => {},
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField).at(1), 'J');
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'c');
    await tester.pumpAndSettle();

    expect(find.text('J'), findsOneWidget);
    expect(nameFieldController.text, 'J');
    expect(
      find.text(AppLocalizationsEn().rangeCharacterCount(60, 2)),
      findsOneWidget,
    );
  });

  testWidgets('Name form field type empty name should show error message',
      (tester) async {
    final nameFieldController = TextEditingController();

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            child: Column(
              children: [
                //Name Form Field only shows error when out of focus, added another text field to change focus
                TextFormField(),
                NameFormField(
                  controller: nameFieldController,
                  onChanged: (_) => {},
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField).at(1), '');
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'c');
    await tester.pumpAndSettle();

    expect(nameFieldController.text, '');
    expect(
      find.text(AppLocalizationsEn().rangeCharacterCount(60, 2)),
      findsOneWidget,
    );
  });
}
