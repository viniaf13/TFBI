import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/vehicles_detail/discount_list.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/vehicles_detail/liability_list.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/vehicles_detail/lienholders_list.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/vehicles_detail/policy_detail_vehicles.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/vehicles_detail/expandable_vehicle_list_item_card.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../../../../mocks/mock_policy_lookup_client.dart';
import '../../../../../mocks/mock_vehicle.dart';
import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  late AutoPolicyDetail details;

  setUp(
    () {
      final AutoPolicyDetail mockPolicyDetails =
          MockPolicy.createAutoPolicyDetail();
      details = AutoPolicyDetail(
        policyType: mockPolicyDetails.policyType,
        policySubType: mockPolicyDetails.policySubType,
        policySymbol: mockPolicyDetails.policySymbol,
        policyAddress: mockPolicyDetails.policyAddress,
        policyBilling: mockPolicyDetails.policyBilling,
        policyNumber: mockPolicyDetails.policyNumber,
        policyDescription: mockPolicyDetails.policyDescription,
        effectiveDate: mockPolicyDetails.effectiveDate,
        expirationDate: mockPolicyDetails.expirationDate,
        vehicles: [
          MockVehicles.generateRandomVehicle(),
          //MockVehicles.generateRandomVehicle(),
        ],
      );
    },
  );

  testWidgets(
    'PolicyDetailVehicles widget should be rendered with correct title',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: PolicyDetailVehicles(details: details),
          ),
        ),
      );

      final foundVehicleCard = find.byType(PolicyDetailVehicles);

      expect(foundVehicleCard, findsOneWidget);
      expect(find.text('Vehicles'), findsOneWidget);
    },
  );

  testWidgets(
    'PolicyDetailVehicles widget should be rendered with correct vehicles',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: PolicyDetailVehicles(details: details),
          ),
        ),
      );

      final foundVehicleCard = find.byType(PolicyDetailVehicles);
      expect(foundVehicleCard, findsOneWidget);

      final foundVehicleItems = find.byType(ExpandableVehicleListItemCard);
      expect(foundVehicleItems, findsWidgets);

      final vehicleItems = tester.widgetList(foundVehicleItems);
      expect(vehicleItems.length, 1);

      final foundLiabilityList = find.byType(LiabilityList);
      final foundLienholdersList = find.byType(LienholdersList);
      final foundDiscountList = find.byType(DiscountList);

      expect(foundLiabilityList, findsNothing);
      expect(foundLienholdersList, findsNothing);
      expect(foundDiscountList, findsNothing);
    },
  );
}
