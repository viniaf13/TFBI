import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_card.dart';

import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  group('PolicyDetailCard Widget Tests', () {
    testWidgets('TfbCard should display the provided child widget',
        (tester) async {
      const childWidget = Text('Tfb Card test');
      await tester.pumpWidget(
        const TfbWidgetTester(
          child: Scaffold(
            body: PolicyDetailCard(child: childWidget),
          ),
        ),
      );

      expect(find.byWidget(childWidget), findsOneWidget);
    });
  });
}
