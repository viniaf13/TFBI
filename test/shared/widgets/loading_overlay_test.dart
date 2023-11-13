import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_loading_overlay.dart';

import '../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('Loading overlay displays the loading icon', (tester) async {
    await tester.pumpWidget(
      const TfbWidgetTester(
        child: Scaffold(body: TfbLoadingOverlay()),
      ),
    );

    expect(
      find.byWidgetPredicate(
        (widget) => widget is Image && widget.image is AssetImage,
      ),
      findsOneWidget,
    );
  });
}
