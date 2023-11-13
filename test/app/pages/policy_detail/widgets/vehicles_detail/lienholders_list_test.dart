import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/vehicles_detail/lienholders_list.dart';
import 'package:txfb_insurance_flutter/domain/models/models.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  late List<LienHolder> mockLienholders;
  setUp(
    () {
      mockLienholders = [
        LienHolder(
          Address(
            'Address test',
            '',
            '',
            'Test City',
            'Test State',
            '1235',
            '',
            '',
          ),
          '',
          '',
          '',
          '',
          'TestName',
          '',
          '',
          '',
          '',
        ),
      ];
    },
  );

  testWidgets(
    'Lienholders widget should be rendered with correct title and items',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: LienholdersList(lienHolders: mockLienholders),
          ),
        ),
      );

      final foundLienholdersList = find.byType(LienholdersList);

      expect(foundLienholdersList, findsOneWidget);
      expect(find.text('Lienholders'), findsOneWidget);

      expect(
        find.text(
          '${mockLienholders[0].address.address1} ${mockLienholders[0].address.city.toCapitalized()}, ${mockLienholders[0].address.state} ${mockLienholders[0].address.zipCode}',
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Lienholders widget should be rendered with correct title and none label when receive empty lienholders list',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const TfbWidgetTester(
          child: Scaffold(
            body: LienholdersList(lienHolders: []),
          ),
        ),
      );

      final foundLienholdersList = find.byType(LienholdersList);

      expect(foundLienholdersList, findsOneWidget);
      expect(find.text('Lienholders'), findsOneWidget);

      expect(find.text('None'), findsOneWidget);
    },
  );
}
