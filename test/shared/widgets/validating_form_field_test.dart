import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/shared/enum/form_validation_type.dart';
import 'package:txfb_insurance_flutter/shared/widgets/validating_form_field.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('Form field is built with validator', (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            child: Column(
              children: [
                ValidatingFormField(
                  labelText: 'test label',
                  type: ValidationType.city,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Chicago');
    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
        (widget) => widget is TextFormField && widget.validator != null,
      ),
      findsOneWidget,
    );
  });
}
