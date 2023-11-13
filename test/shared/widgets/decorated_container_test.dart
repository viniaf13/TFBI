import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/shared/widgets/decorated_container.dart';

import '../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('DecoratedContainer displays child widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const TfbWidgetTester(
        child: DecoratedContainer(
          child: Text('Test Child'),
        ),
      ),
    );

    expect(find.text('Test Child'), findsOneWidget);
  });

  testWidgets('DecoratedContainer has specified height',
      (WidgetTester tester) async {
    const double containerHeight = 100;

    await tester.pumpWidget(
      TfbWidgetTester(
        child: DecoratedContainer(
          height: containerHeight,
          child: Container(),
        ),
      ),
    );

    final decoratedContainer = find.byWidgetPredicate(
      (widget) =>
          widget is DecoratedContainer && widget.height == containerHeight,
    );

    expect(decoratedContainer, findsOneWidget);
  });
}
