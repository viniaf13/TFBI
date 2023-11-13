import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/shared/widgets/decorated_container_with_loading.dart';

import '../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('DecoratedContainerWithLoading displays loading spinner',
      (WidgetTester tester) async {
    const double containerHeight = 200;
    const double spinnerHeight = 50;

    await tester.pumpWidget(
      const TfbWidgetTester(
        child: DecoratedContainerWithLoading(
          containerHeight: containerHeight,
          spinnerHeight: spinnerHeight,
        ),
      ),
    );

    final loadingSpinner = find.byWidgetPredicate(
      (widget) =>
          widget is DecoratedContainerWithLoading &&
          widget.spinnerHeight == spinnerHeight,
    );

    expect(loadingSpinner, findsOneWidget);
  });
}
