import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/describe_injuries_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/was_anyone_injured.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/yesno_button.dart';
import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets(
      'Was anyone injured yes/no, should have child when enum is set to yes.',
      (tester) async {
    final describeInjuriesFieldController = TextEditingController();
    final valueNotifier = ValueNotifier<YesNoButtonKind?>(null);
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: WasAnyoneInjured(
            textEditingController: describeInjuriesFieldController,
            yesNoValueNotifier: valueNotifier,
            onChange: (_) {},
          ),
        ),
      ),
    );
    await tester.tap(
      find.byWidgetPredicate(
        (w) => w is YesNoButton && w.kind == YesNoButtonKind.yes,
      ),
    );
    await tester.pump(
      const Duration(
        milliseconds: 250,
      ),
    );
    expect(
      find.byType(DescribeInjuriesFormField),
      findsOneWidget,
    );
  });

  testWidgets(
      'Was anyone injured yes/no, should NOT have child when enum is set to no.',
      (tester) async {
    final describeInjuriesFieldController = TextEditingController();
    final valueNotifier = ValueNotifier<YesNoButtonKind?>(null);
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: WasAnyoneInjured(
            textEditingController: describeInjuriesFieldController,
            yesNoValueNotifier: valueNotifier,
            onChange: (_) {},
          ),
        ),
      ),
    );
    await tester.tap(
      find.byWidgetPredicate(
        (w) => w is YesNoButton && w.kind == YesNoButtonKind.no,
      ),
    );
    await tester.pump(
      const Duration(
        milliseconds: 250,
      ),
    );
    expect(
      find.byType(DescribeInjuriesFormField),
      findsNothing,
    );
  });
}
