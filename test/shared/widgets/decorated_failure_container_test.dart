import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/shared/widgets/decorated_failure_container.dart';

import '../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('DecoratedFailureContainer displays error text correctly',
      (WidgetTester tester) async {
    const errorDescription = 'Test Error Description';

    await tester.pumpWidget(
      const TfbWidgetTester(
        child: DecoratedFailureContainer(errorDescription: errorDescription),
      ),
    );

    expect(find.text(errorDescription), findsOneWidget);
  });
}
