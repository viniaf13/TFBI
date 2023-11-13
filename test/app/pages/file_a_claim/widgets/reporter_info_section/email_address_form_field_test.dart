import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/reporter_info_section/email_address_form_field.dart';

import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('Email form field type valid email should not show error message',
      (tester) async {
    final emailFieldController = TextEditingController();

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            child: Column(
              children: [
                //Email Form Field only shows error when out of focus, added another text field to change focus
                TextFormField(),
                EmailAddressFormField(
                  controller: emailFieldController,
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
      'email@provider.com',
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'c');
    await tester.pumpAndSettle();

    expect(find.text('email@provider.com'), findsOneWidget);
    expect(emailFieldController.text, 'email@provider.com');
    expect(
      find.text(AppLocalizationsEn().validFieldValidation('email address')),
      findsNothing,
    );
  });

  testWidgets('Email form field type invalid email should show error message',
      (tester) async {
    final emailFieldController = TextEditingController();

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            child: Column(
              children: [
                //Email Form Field only shows error when out of focus, added another text field to change focus
                TextFormField(),
                EmailAddressFormField(
                  controller: emailFieldController,
                  onChanged: (_) => {},
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField).at(1), 'invalid-email');
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'c');
    await tester.pumpAndSettle();

    expect(find.text('invalid-email'), findsOneWidget);
    expect(emailFieldController.text, 'invalid-email');
    expect(
      find.text(AppLocalizationsEn().validFieldValidation('email address')),
      findsOneWidget,
    );
  });

  testWidgets('Email form field type empty email should not show error message',
      (tester) async {
    final emailFieldController = TextEditingController();

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            child: Column(
              children: [
                //Email Form Field only shows error when out of focus, added another text field to change focus
                TextFormField(),
                EmailAddressFormField(
                  controller: emailFieldController,
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

    expect(emailFieldController.text, '');
    expect(
      find.text(AppLocalizationsEn().validFieldValidation('email address')),
      findsNothing,
    );
  });
}
