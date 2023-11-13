import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claims_empty_view.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('Header should have a text block', (WidgetTester tester) async {
    await tester.pumpWidget(
      const TfbWidgetTester(
        child: ClaimsEmptyView(),
      ),
    );

    expect(find.byType(Text), findsOneWidget);
  });
}
