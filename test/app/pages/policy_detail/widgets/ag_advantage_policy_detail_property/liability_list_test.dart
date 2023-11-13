import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/ag_advantage_property_detail/expandable_property_item.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/ag_advantage_property_detail/liability_list.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../../../../mocks/mock_policy_lookup_client.dart';
import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  late List<AgAdvantageSection> mockSections;

  setUp(() {
    final mockPolicyDetails = MockPolicy.createAgAdvantagePolicyDetail();

    mockSections = mockPolicyDetails.sections;
  });

  testWidgets(
    'LiabilitySection widget should render title and liabilities sections correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: LiabilityList(sections: mockSections),
          ),
        ),
      );

      final liabilityListWidget = find.byType(LiabilityList);
      final expandablePropertyItem = find.byType(ExpandablePropertyItem);

      expect(liabilityListWidget, findsOneWidget);
      expect(expandablePropertyItem, findsWidgets);
      expect(find.text('Liability'), findsOneWidget);

      expect(find.text(mockSections[0].name), findsOneWidget);
      expect(find.text(mockSections[1].name), findsOneWidget);
    },
  );
}
