import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_phone.dart';

import '../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('Phone number widget contains the phone number', (tester) async {
    await tester.pumpWidget(
      const TfbWidgetTester(
        child: Scaffold(
          body: TextWithPhone(
            phoneNumberForDialing: '123456789',
            phoneNumberForDisplay: '123456789',
          ),
        ),
      ),
    );

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is TextWithPhone &&
            widget.phoneNumberForDisplay == '123456789',
      ),
      findsOneWidget,
    );
  });
}
