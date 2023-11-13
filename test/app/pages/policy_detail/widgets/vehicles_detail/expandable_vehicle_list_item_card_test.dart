import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/vehicles_detail/expandable_vehicle_list_item_card.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/widgets/expandable_card/expandable_card.dart';
import 'package:txfb_insurance_flutter/shared/widgets/expandable_card/expandable_section_content.dart';

import '../../../../../mocks/mock_vehicle.dart';
import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  late Vehicle mockVehicle;

  setUp(
    () {
      mockVehicle = MockVehicles.generateRandomVehicle();
    },
  );

  testWidgets(
    'ExpandableVehicleListItemCard widget should be rendered with expandable card and content correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: ExpandableVehicleListItemCard(mockVehicle),
          ),
        ),
      );

      final foundVehicleCard = find.byType(ExpandableVehicleListItemCard);
      final foundExpandableCard = find.byType(ExpandableCard);
      final foundExpandableContent = find.byType(ExpandableSectionContent);

      expect(foundVehicleCard, findsOneWidget);
      expect(foundExpandableCard, findsOneWidget);
      expect(foundExpandableContent, findsOneWidget);
    },
  );

  testWidgets(
    'ExpandableVehicleListItemCard widget should be rendered with correct vehicle information',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: ExpandableVehicleListItemCard(mockVehicle),
          ),
        ),
      );

      final foundVehicleCard = find.byType(ExpandableVehicleListItemCard);

      expect(foundVehicleCard, findsOneWidget);
      expect(
        find.text(
          '${mockVehicle.year} ${mockVehicle.make} ${mockVehicle.model}',
        ),
        findsOneWidget,
      );
      expect(find.text('VIN: ${mockVehicle.vin}'), findsOneWidget);
      expect(
        find.text(
          'Current vehicle premium: \$${mockVehicle.totalVehiclePremium}',
        ),
        findsOneWidget,
      );
    },
  );
}
