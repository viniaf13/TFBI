import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/city_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('City form field type valid city should not show error message',
      (tester) async {
    final cityFieldController = TextEditingController();
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            child: Column(
              children: [
                //City Form Field only shows error when out of focus, added another text field to change focus
                TextFormField(),
                CityFormField(
                  controller: cityFieldController,
                  onChanged: (_) => {},
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField).at(1), 'Chicago');
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'c');
    await tester.pumpAndSettle();

    expect(find.text('Chicago'), findsOneWidget);
    expect(cityFieldController.text, 'Chicago');
    expect(
      find.text(AppLocalizationsEn().rangeCharacterCount(25, 3)),
      findsNothing,
    );
  });

  testWidgets(
      'City form field type less than 3 characters should show error message',
      (tester) async {
    final cityFieldController = TextEditingController();
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            child: Column(
              children: [
                //City Form Field only shows error when out of focus, added another text field to change focus
                TextFormField(),
                CityFormField(
                  controller: cityFieldController,
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
    expect(cityFieldController.text, 'D');
    expect(
      find.text(AppLocalizationsEn().rangeCharacterCount(25, 3)),
      findsOneWidget,
    );
  });

  testWidgets(
      'City form field type more than 25 characters should not allow more than 25',
      (tester) async {
    final cityFieldController = TextEditingController();
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            child: Column(
              children: [
                CityFormField(
                  controller: cityFieldController,
                  onChanged: (_) => {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
    const textLargerThanMax = 'qwertyuioplkjhgfdsazxcvbnmkjhg';
    await tester.enterText(find.byType(TextFormField), textLargerThanMax);
    await tester.pumpAndSettle();
    expect(find.text(textLargerThanMax), findsNothing);
    expect(cityFieldController.text, '');
  });

  testWidgets('City form field type empty should show error message',
      (tester) async {
    final cityFieldController = TextEditingController();
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            child: Column(
              children: [
                //City Form Field only shows error when out of focus, added another text field to change focus
                TextFormField(),
                CityFormField(
                  controller: cityFieldController,
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
    expect(cityFieldController.text, '');
    expect(
      find.text(AppLocalizationsEn().rangeCharacterCount(25, 3)),
      findsOneWidget,
    );
  });
}
