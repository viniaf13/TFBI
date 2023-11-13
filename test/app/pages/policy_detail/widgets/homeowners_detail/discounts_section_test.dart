import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/homeowners_property_detail/discounts_section.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  late List<HomeownerDiscount> mockDiscounts;

  setUp(
    () {
      mockDiscounts = [
        HomeownerDiscount(
          'Claims Free',
          '-334',
        ),
        HomeownerDiscount(
          'Companion Policy',
          '-295',
        ),
      ];
    },
  );

  testWidgets(
    'DiscountsSection widget should render title and discounts list correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: DiscountsSection(discounts: mockDiscounts),
          ),
        ),
      );

      final discountSectionWidget = find.byType(DiscountsSection);

      expect(discountSectionWidget, findsOneWidget);
      expect(find.text('Discounts'), findsOneWidget);

      for (final discount in mockDiscounts) {
        expect(find.text(discount.name), findsOneWidget);
      }
    },
  );
}
