import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claim_details/claim_details_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_auto_success/widgets/claim_information_card.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';

import '../../../../mocks/mock_claim_details_bloc.dart';
import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  late MockClaimDetailsBloc claimDetailsBloc;

  setUp(
    () {
      registerFallbackValue(ClaimDetailsInitState());
      claimDetailsBloc = MockClaimDetailsBloc();
      when(() => claimDetailsBloc.state).thenReturn(
        mockClaimDetailsSuccess,
      );
    },
  );
  testWidgets('claim information card should display claim info',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider<ClaimDetailsBloc>.value(
          value: claimDetailsBloc,
          child: ClaimInformationCard(
            claimNumber: '12345678',
            dateOfLoss: '01/01/2023',
            policySelection: PolicySelection(
              insuredName: 'John Doe',
              policyType: PolicyType.txPersonalAuto,
              policyNumber: '12345678',
              policySymbol: 'PA6',
            ),
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
      find.text('Personal Auto # 12345678'),
      findsOneWidget,
    );
    expect(
      find.text('01/01/2023'),
      findsOneWidget,
    );
    expect(
      find.text('John Doe'),
      findsOneWidget,
    );
    expect(
      find.text('Email claims rep'),
      findsOneWidget,
    );
    expect(
      find.text('1234567890'),
      findsOneWidget,
    );
  });
}
