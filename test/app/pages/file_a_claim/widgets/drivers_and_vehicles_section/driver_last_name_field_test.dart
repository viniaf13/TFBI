import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/driver_last_name_field.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../../../../widgets/tfb_widget_tester.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

void main() {
  late TextEditingController controller = TextEditingController();

  setUp(() {
    controller = TextEditingController();
  });

  testWidgets('Driver first name field label', (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: TfbDriverLastName(controller: controller, onChanged: (_) {}),
        ),
      ),
    );

    expect(
      find.text(AppLocalizationsEn().insuredDriverLastNameFieldLabel),
      findsOneWidget,
    );
  });

  testWidgets('should not show any error message with valid string',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Column(
            children: [
              TfbDriverLastName(controller: controller, onChanged: (_) {}),
              const TextField(),
            ],
          ),
        ),
      ),
    );
    final textInputField = find.byType(TfbDriverLastName);
    final fieldTester = find.byType(TextField).last;
    await tester.tap(textInputField);
    await tester.enterText(textInputField, 'valid');
    await tester.pumpAndSettle();
    await tester.tap(fieldTester);
    await tester.pumpAndSettle();

    expect(
      find.text(AppLocalizationsEn().minMaxLengthValidationMessage(25, 2)),
      findsNothing,
    );
  });

  testWidgets('should show mixmax char error message on blur with empty field',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Column(
            children: [
              TfbDriverLastName(controller: controller, onChanged: (_) {}),
              const TextField(),
            ],
          ),
        ),
      ),
    );
    final textInputField = find.byType(TfbDriverLastName);
    final fieldTester = find.byType(TextField).last;
    await tester.tap(textInputField);
    await tester.pumpAndSettle();
    await tester.tap(fieldTester);
    await tester.pumpAndSettle();

    expect(
      find.text(AppLocalizationsEn().minMaxLengthValidationMessage(25, 2)),
      findsOneWidget,
    );
  });

  testWidgets('should show mixmax char error message on blur with single char',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Column(
            children: [
              TfbDriverLastName(controller: controller, onChanged: (_) {}),
              const TextField(),
            ],
          ),
        ),
      ),
    );
    final textInputField = find.byType(TfbDriverLastName);
    final fieldTester = find.byType(TextField).last;
    await tester.tap(textInputField);
    await tester.enterText(textInputField, 'a');
    await tester.pumpAndSettle();
    await tester.tap(fieldTester);
    await tester.pumpAndSettle();

    expect(
      find.text(AppLocalizationsEn().minMaxLengthValidationMessage(25, 2)),
      findsOneWidget,
    );
  });
}
