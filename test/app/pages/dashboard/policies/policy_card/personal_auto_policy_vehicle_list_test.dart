import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/policies/policy_card/personal_auto_policy_vehicle_list.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/auto_policy_detail.dart';

import '../../../../../mocks/mock_policy_lookup_client.dart';
import '../../../../../mocks/mock_vehicle.dart';
import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  late AutoPolicyDetail mockAutoPolicyDetail;
  late List<Vehicle> mockVehicleList;

  setUp(
    () {
      mockAutoPolicyDetail = MockPolicy.createAutoPolicyDetail();
      mockVehicleList = [
        MockVehicles.generateRandomVehicle(),
        MockVehicles.generateRandomVehicle(),
        MockVehicles.generateRandomVehicle(),
        MockVehicles.generateRandomVehicle(),
      ];
    },
  );

  testWidgets(
    'Should display vehicle list correctly when there only one vehicle',
    (WidgetTester tester) async {
      mockAutoPolicyDetail.vehicles.clear();
      mockAutoPolicyDetail.vehicles.add(mockVehicleList[0]);

      await tester.pumpWidget(
        TfbWidgetTester(
          child: SizedBox(
            height: 800,
            child: Column(
              children: [
                PersonalAutoPolicyVehicleList(mockAutoPolicyDetail),
              ],
            ),
          ),
        ),
      );

      expect(
        find.text(mockAutoPolicyDetail.vehicles[0].yearMakeModel),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Should display vehicle list correctly when there two vehicles',
    (WidgetTester tester) async {
      mockAutoPolicyDetail.vehicles.clear();

      mockAutoPolicyDetail.vehicles.add(mockVehicleList[0]);
      mockAutoPolicyDetail.vehicles.add(mockVehicleList[1]);

      await tester.pumpWidget(
        TfbWidgetTester(
          child: SizedBox(
            height: 800,
            child: Column(
              children: [
                PersonalAutoPolicyVehicleList(mockAutoPolicyDetail),
              ],
            ),
          ),
        ),
      );

      expect(
        find.text(mockAutoPolicyDetail.vehicles[0].yearMakeModel),
        findsOneWidget,
      );

      expect(
        find.text(mockAutoPolicyDetail.vehicles[1].yearMakeModel),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Should display vehicle list correctly when three vehicles',
    (WidgetTester tester) async {
      mockAutoPolicyDetail.vehicles.clear();

      mockAutoPolicyDetail.vehicles.add(mockVehicleList[0]);
      mockAutoPolicyDetail.vehicles.add(mockVehicleList[1]);
      mockAutoPolicyDetail.vehicles.add(mockVehicleList[2]);

      await tester.pumpWidget(
        TfbWidgetTester(
          child: SizedBox(
            height: 800,
            child: Column(
              children: [
                PersonalAutoPolicyVehicleList(mockAutoPolicyDetail),
              ],
            ),
          ),
        ),
      );

      expect(
        find.text(mockAutoPolicyDetail.vehicles[0].yearMakeModel),
        findsOneWidget,
      );

      expect(
        find.text(mockAutoPolicyDetail.vehicles[1].yearMakeModel),
        findsOneWidget,
      );

      expect(
        find.text(mockAutoPolicyDetail.vehicles[2].yearMakeModel),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Should display vehicle list correctly when there more then three vehicles',
    (WidgetTester tester) async {
      mockAutoPolicyDetail.vehicles.clear();

      mockAutoPolicyDetail.vehicles.add(mockVehicleList[0]);
      mockAutoPolicyDetail.vehicles.add(mockVehicleList[1]);
      mockAutoPolicyDetail.vehicles.add(mockVehicleList[2]);
      mockAutoPolicyDetail.vehicles.add(mockVehicleList[3]);

      await tester.pumpWidget(
        TfbWidgetTester(
          child: SizedBox(
            height: 800,
            child: Column(
              children: [
                PersonalAutoPolicyVehicleList(mockAutoPolicyDetail),
              ],
            ),
          ),
        ),
      );

      expect(
        find.text(mockAutoPolicyDetail.vehicles[0].yearMakeModel),
        findsOneWidget,
      );
      expect(
        find.text(mockAutoPolicyDetail.vehicles[1].yearMakeModel),
        findsOneWidget,
      );
      expect(
        find.text(mockAutoPolicyDetail.vehicles[2].yearMakeModel),
        findsOneWidget,
      );

      expect(find.text('+1 more'), findsOneWidget);
    },
  );
}
