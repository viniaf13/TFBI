import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/shared/widgets/separator_line.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('Separator is gray', (tester) async {
    await tester.pumpWidget(
      const TfbWidgetTester(
        child: Scaffold(body: SeparatorLine()),
      ),
    );

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container && widget.color == TfbBrandColors.grayMedium,
      ),
      findsOneWidget,
    );
  });
}
