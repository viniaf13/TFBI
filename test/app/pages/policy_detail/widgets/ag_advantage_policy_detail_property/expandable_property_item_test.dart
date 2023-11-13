import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/ag_advantage_property_detail/expandable_property_item.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/dual_color_list/dual_color_list.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../../../../mocks/mock_policy_lookup_client.dart';
import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  late AgAdvantageSection mockSection;

  setUp(() {
    final mockPolicyDetails = MockPolicy.createAgAdvantagePolicyDetail();

    mockSection = mockPolicyDetails.sections[0];
  });

  testWidgets(
    'ExpandablePropertyItem widget should be render with title and coverage list hidden',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: ExpandablePropertyItem(mockSection),
          ),
        ),
      );

      final expandablePropertyItem = find.byType(ExpandablePropertyItem);
      final dualColorList = find.byType(DualColorList);

      expect(expandablePropertyItem, findsOneWidget);
      expect(dualColorList, findsNothing);

      expect(find.text(mockSection.name), findsOneWidget);
    },
  );

  testWidgets(
    'DualColorList widget should be visible when ExpandablePropertyItem is clicked',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: ExpandablePropertyItem(mockSection),
          ),
        ),
      );

      final expandablePropertyItem = find.byType(ExpandablePropertyItem);

      expect(expandablePropertyItem, findsOneWidget);
      await tester.tap(expandablePropertyItem);

      await tester.pumpAndSettle();

      final dualColorList = find.byType(DualColorList);
      expect(dualColorList, findsOneWidget);
    },
  );
}
