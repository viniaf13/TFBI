import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/ag_advantage_property_detail/discounts_list.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  late List<AgAdvantageDiscount> mockDiscounts;

  setUp(
    () {
      mockDiscounts = [
        AgAdvantageDiscount(
          'Claims Free',
          '-334',
        ),
        AgAdvantageDiscount(
          'Companion Policy',
          '-295',
        ),
      ];
    },
  );

  testWidgets(
    'DiscountsList widget should render title and discounts list correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: DiscountsList(discounts: mockDiscounts),
          ),
        ),
      );

      final discountSectionWidget = find.byType(DiscountsList);

      expect(discountSectionWidget, findsOneWidget);
      expect(find.text('Discounts'), findsOneWidget);

      for (final discount in mockDiscounts) {
        expect(find.text(discount.name), findsOneWidget);
      }
    },
  );
}
