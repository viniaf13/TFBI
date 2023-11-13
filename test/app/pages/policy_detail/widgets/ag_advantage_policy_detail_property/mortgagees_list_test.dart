import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/mortgagees_list.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/mortgagee.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  late List<Mortgagee> mockMortgagees;

  setUp(
    () {
      mockMortgagees = [
        Mortgagee(
          'PO BOX 100515, FLORENCE SC 29502',
          '',
          'WELLS FARGO BANK NA #936',
          '1',
          'DWL',
          'MTG',
        ),
        Mortgagee(
          'FLORENCE SC 1111',
          '',
          'BANK NA FARGO',
          '1',
          'DWL',
          'MTG',
        ),
      ];
    },
  );

  testWidgets(
    'MortgageesList widget should render title and mortgagees list correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: MortgageesList(mortgagees: mockMortgagees),
          ),
        ),
      );

      expect(find.byType(MortgageesList), findsOneWidget);
    },
  );
}
