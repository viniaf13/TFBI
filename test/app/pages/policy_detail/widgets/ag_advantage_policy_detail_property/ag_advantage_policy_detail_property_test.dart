import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/ag_advantage_property_detail/ag_advantage_policy_detail_property.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/ag_advantage_property_detail/discounts_list.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/ag_advantage_property_detail/liability_list.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/mortgagees_list.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

import '../../../../../mocks/mock_policy_lookup_client.dart';
import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  late AgAdvantagePolicyDetail mockPolicyDetails;

  setUp(
    () {
      mockPolicyDetails = MockPolicy.createAgAdvantagePolicyDetail();
    },
  );

  testWidgets(
    'AgAdvantagePolicyDetailProperty widget should be rendered with correct title and address',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: AgAdvantagePolicyDetailProperty(details: mockPolicyDetails),
          ),
        ),
      );

      final foundAgAdvantagePolicyDetailProperty =
          find.byType(AgAdvantagePolicyDetailProperty);
      final foundAddressWidget = find.byType(AddressWidget);

      expect(foundAgAdvantagePolicyDetailProperty, findsOneWidget);
      expect(foundAddressWidget, findsOneWidget);
      expect(find.text('Property'), findsOneWidget);
    },
  );

  testWidgets(
    'AgAdvantagePolicyDetailProperty widget should be rendered with liability, discounts and mortgagees list',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: AgAdvantagePolicyDetailProperty(details: mockPolicyDetails),
          ),
        ),
      );

      final foundAgAdvantagePolicyDetailProperty =
          find.byType(AgAdvantagePolicyDetailProperty);
      expect(foundAgAdvantagePolicyDetailProperty, findsOneWidget);

      final foundLiabilityList = find.byType(LiabilityList);
      final foundMortgageesList = find.byType(MortgageesList);
      final foundDiscountList = find.byType(DiscountsList);

      expect(foundLiabilityList, findsNothing);
      expect(foundMortgageesList, findsNothing);
      expect(foundDiscountList, findsNothing);
    },
  );
}
