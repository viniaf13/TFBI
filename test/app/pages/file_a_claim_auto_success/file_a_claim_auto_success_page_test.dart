import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claim_details/claim_details_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_auto_success/file_a_claim_personal_auto_success_content.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_auto_success/widgets/claim_information_card.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_auto_success/widgets/claim_success_header.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_auto_success/widgets/done_cta.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';

import '../../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../../mocks/mock_claim_details_bloc.dart';
import '../../../widgets/tfb_widget_tester.dart';

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

  testWidgets('file a claim auto success page should display claim information',
      (tester) async {
    final mockStatusBarScrollCubit = MockStatusBarScrollCubit();
    when(() => mockStatusBarScrollCubit.state)
        .thenReturn(const StatusBarScrollInitial(''));

    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: BlocProvider<ClaimDetailsBloc>.value(
          value: claimDetailsBloc,
          child: FileAClaimPersonalAutoSuccessContent(
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
