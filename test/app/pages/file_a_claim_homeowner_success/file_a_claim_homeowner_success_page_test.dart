import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_homeowner_success/file_a_claim_homeowner_success_page.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_homeowner_success/widgets/claim_information_card.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_homeowner_success/widgets/claim_success_header.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_homeowner_success/widgets/done_cta.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

import '../../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('file a claim homeowner success page should render correctly',
      (tester) async {
    final mockStatusBarScrollCubit = MockStatusBarScrollCubit();
    when(() => mockStatusBarScrollCubit.state)
        .thenReturn(const StatusBarScrollInitial(''));

    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: FileAClaimHomeownerSuccessPage(
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
      find.byType(ClaimSuccessHeader),
      findsOneWidget,
    );
    expect(
      find.byType(ClaimInformationCard),
      findsOneWidget,
    );
    expect(
      find.byType(DoneCta),
      findsOneWidget,
    );
  });
}
