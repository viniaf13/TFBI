import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/contact_phone_number_form_field.dart';

import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('Phone form field type valid phone should not show error message',
      (tester) async {
    final phoneFieldController = TextEditingController();

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            child: Column(
              children: [
                //Phone Form Field only shows error when out of focus, added another text field to change focus
                TextFormField(),
                ContactPhoneNumberFormField(
                  label: '',
                  controller: phoneFieldController,
                  onChanged: (_) => {},
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField).at(1), '1234567890');
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'c');
    await tester.pumpAndSettle();

    expect(find.text('123.456.7890'), findsOneWidget);
    expect(phoneFieldController.text, '123.456.7890');
    expect(
      find.text(AppLocalizationsEn().validFieldValidation('phone number')),
      findsNothing,
    );
  });

  testWidgets('Phone form field type invalid phone should show error message',
      (tester) async {
    final phoneFieldController = TextEditingController();

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            child: Column(
              children: [
                //Phone Form Field only shows error when out of focus, added another text field to change focus
                TextFormField(),
                ContactPhoneNumberFormField(
                  label: '',
                  controller: phoneFieldController,
                  onChanged: (_) => {},
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField).at(1), '123');
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'c');
    await tester.pumpAndSettle();

    expect(find.text('123'), findsOneWidget);
    expect(phoneFieldController.text, '123');
    expect(
      find.text(AppLocalizationsEn().validFieldValidation('phone number')),
      findsOneWidget,
    );
  });

  testWidgets('Phone form field type empty phone should show error message',
      (tester) async {
    final phoneFieldController = TextEditingController();

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            child: Column(
              children: [
                //Phone Form Field only shows error when out of focus, added another text field to change focus
                TextFormField(),
                ContactPhoneNumberFormField(
                  label: '',
                  controller: phoneFieldController,
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

    expect(phoneFieldController.text, '');
    expect(
      find.text(AppLocalizationsEn().rangeCharacterCount(12, 10)),
      findsOneWidget,
    );
  });
}
