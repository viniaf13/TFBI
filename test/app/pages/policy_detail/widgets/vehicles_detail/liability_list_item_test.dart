import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/dual_color_list/dual_color_list_item.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  const String label = 'Mock Label';
  final List<String> values = ['\$100,00/person', '\$200,00/person'];

  testWidgets(
    'DualColorListItem widget should be rendered with label and values',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: DualColorListItem(label: label, values: values),
          ),
        ),
      );

      final foundLiabilityListItem = find.byType(DualColorListItem);

      expect(foundLiabilityListItem, findsOneWidget);
      expect(find.text(label), findsOneWidget);
      expect(find.text(values[0]), findsOneWidget);
      expect(find.text(values[1]), findsOneWidget);
    },
  );
}
