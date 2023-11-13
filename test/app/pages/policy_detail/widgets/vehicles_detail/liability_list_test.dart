import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/vehicles_detail/liability_list.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/dual_color_list/dual_color_list_item.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/auto_policy_detail.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  late List<Coverage> mockCoverages;
  setUp(
    () {
      mockCoverages = [
        Coverage(
          '80',
          'Test Injury',
          '0',
          'Test Injury',
          '50/100',
          ['\$50,000 each person', '\$100,000 each accident'],
          '129.00',
          '',
        ),
        Coverage(
          '40',
          'Test Damage',
          '0',
          'Test Damage',
          '50',
          ['\$80,000 each person'],
          '',
          '',
        ),
      ];
    },
  );

  testWidgets(
    'LiabilityList widget should be rendered with correct title and items',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: LiabilityList(coverages: mockCoverages),
          ),
        ),
      );

      final foundLiabilityList = find.byType(LiabilityList);

      expect(foundLiabilityList, findsOneWidget);
      expect(find.text('Liability'), findsOneWidget);

      final foundLiabilityListItem = find.byType(DualColorListItem);

      expect(foundLiabilityListItem, findsWidgets);
      expect(
        find.text(mockCoverages[0].coverageTypeDescription),
        findsOneWidget,
      );
      expect(
        find.text(
          mockCoverages[0].limitDescription[0].replaceAll(' each ', '/'),
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'LiabilityList widget should be rendered with correct title and none label when receive empty liability list',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const TfbWidgetTester(
          child: Scaffold(
            body: LiabilityList(coverages: []),
          ),
        ),
      );

      final foundLienholdersList = find.byType(LiabilityList);

      expect(foundLienholdersList, findsOneWidget);
      expect(find.text('Liability'), findsOneWidget);

      expect(find.text('None'), findsOneWidget);
    },
  );
}
