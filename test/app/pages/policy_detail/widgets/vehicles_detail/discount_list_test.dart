import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/vehicles_detail/discount_list.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/auto_policy_detail.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  late List<Discount> mockDiscounts;
  setUp(
    () {
      mockDiscounts = [
        Discount(
          'code',
          '880',
          '-17.00',
          'discountAmountDescription',
          'Companion Discounts',
          '-17.00',
        ),
        Discount(
          'code',
          '880',
          '-17.00',
          'discountAmountDescription',
          'Multi-Car Discounts',
          '-17.00',
        ),
      ];
    },
  );

  testWidgets(
    'DiscountList widget should be rendered with correct title and items',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: DiscountList(discounts: mockDiscounts),
          ),
        ),
      );

      final foundDiscountList = find.byType(DiscountList);

      expect(foundDiscountList, findsOneWidget);
      expect(find.text('Discounts'), findsOneWidget);

      expect(find.text(mockDiscounts[0].discountType), findsOneWidget);
      expect(find.text(mockDiscounts[1].discountType), findsOneWidget);
    },
  );

  testWidgets(
    'DiscountList widget should be rendered with correct title and none label when receive empty discounts list',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const TfbWidgetTester(
          child: Scaffold(
            body: DiscountList(discounts: []),
          ),
        ),
      );

      final foundDiscountList = find.byType(DiscountList);

      expect(foundDiscountList, findsOneWidget);
      expect(find.text('Discounts'), findsOneWidget);

      expect(find.text('None'), findsOneWidget);
    },
  );
}
