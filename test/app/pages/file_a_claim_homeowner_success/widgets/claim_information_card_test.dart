import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_homeowner_success/widgets/claim_information_card.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';

import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('claim information card should display claim info',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: ClaimInformationCard(
          confirmationNumber: '12345678',
          dateOfLoss: '01/01/2023',
          policy: PolicySelection(
            insuredName: 'John Doe',
            policyType: PolicyType.homeowners,
            policyNumber: '12345678',
            policySymbol: 'HO6',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.text('#12345678'),
      findsOneWidget,
    );
    expect(
      find.text('Home # 12345678'),
      findsOneWidget,
    );
    expect(
      find.text('01/01/2023'),
      findsOneWidget,
    );
  });
}
