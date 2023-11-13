import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claims_header_view.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('Header should have a filled button',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const TfbWidgetTester(
        child: ClaimsHeaderView(),
      ),
    );

    expect(find.byType(TfbFilledButton), findsOneWidget);
  });
}
