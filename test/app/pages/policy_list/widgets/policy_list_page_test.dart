import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/policies_list/policy_list_page.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/member_summary.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_snackbar_content.dart';

import '../../../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../../../mocks/mock_member_summary.dart';
import '../../../../mocks/mock_policy_lookup_client.dart';
import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  late MockMemberSummaryCubit cubit;
  final mockStatusBarScrollCubit = MockStatusBarScrollCubit();

  setUp(
    () {
      mocktail.registerFallbackValue(FakeMemberSummaryState());
      cubit = MockMemberSummaryCubit();
    },
  );

  testWidgets(
      'Member Summary display SnackBar when state of MemberSummary is failure',
      (WidgetTester tester) async {
    final initialState = MemberSummaryInitial();
    final errorState = MemberSummaryFailure(error: TfbRequestError());

    mocktail.when(() => cubit.state).thenReturn(
          initialState,
        );

    mocktail.when(() => cubit.state).thenReturn(errorState);

    mocktail
        .when(() => mockStatusBarScrollCubit.state)
        .thenReturn(const StatusBarScrollInitial(''));

    final expectedStates = [
      initialState,
      errorState,
    ];

    whenListen(cubit, Stream.fromIterable(expectedStates));

    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: BlocProvider<MemberSummaryCubit>.value(
          value: cubit,
          child: const PolicyListPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(TfbSnackbarContent), findsOneWidget);
  });

  testWidgets(
      'Member Summary dont display SnackBar when getMemberSummary completes '
      'with an success', (WidgetTester tester) async {
    mocktail.when(() => cubit.state).thenReturn(
          MemberSummarySuccess(
            memberSummary: MemberSummary(
              policies: [
                MockPolicy.createPolicySummary(),
                MockPolicy.createPolicySummary(
                  policyType: PolicyType.txPersonalAuto,
                ),
              ],
            ),
          ),
        );

    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: BlocProvider<MemberSummaryCubit>.value(
          value: cubit,
          child: const PolicyListPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Personal Auto'), findsOneWidget);
  });
}
