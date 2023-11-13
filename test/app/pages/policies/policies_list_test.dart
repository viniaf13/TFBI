import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/policies_list/policy_list_item.dart';
import 'package:txfb_insurance_flutter/app/pages/policies_list/policy_list_page.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/member_summary.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';

import '../../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../../mocks/mock_member_summary.dart';
import '../../../mocks/mock_policy_lookup_client.dart';
import '../../../widgets/tfb_widget_tester.dart';

void main() {
  late MockMemberSummaryCubit memberSummaryCubit;
  final mockStatusBarScrollCubit = MockStatusBarScrollCubit();

  setUpAll(() {
    mocktail.registerFallbackValue(FakeMemberSummaryState());
  });

  setUp(() {
    memberSummaryCubit = MockMemberSummaryCubit();
    when(() => mockStatusBarScrollCubit.state)
        .thenReturn(const StatusBarScrollInitial(''));
  });

  testWidgets('Policy List loading state', (tester) async {
    mocktail
        .when(() => memberSummaryCubit.state)
        .thenReturn(MemberSummaryInitial());

    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: BlocProvider<MemberSummaryCubit>.value(
          value: memberSummaryCubit,
          child: const PolicyListPage(),
        ),
      ),
    );

    expect(find.byType(TfbBrandLoadingIcon), findsOneWidget);
  });

  testWidgets('Policy List contains expected policy list items',
      (tester) async {
    mocktail.when(() => memberSummaryCubit.state).thenReturn(
          MemberSummarySuccess(
            memberSummary: MemberSummary(
              policies: [
                MockPolicy.createPolicySummary(),
                MockPolicy.createPolicySummary(
                  policyType: PolicyType.txPersonalAuto,
                ),
                MockPolicy.createPolicySummary(
                  policyType: PolicyType.agAdvantage,
                ),
                MockPolicy.createPolicySummary(
                  policyType: PolicyType.inlandMarine,
                ),
              ],
            ),
          ),
        );

    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: BlocProvider<MemberSummaryCubit>.value(
          value: memberSummaryCubit,
          child: const PolicyListPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(PolicyListItem), findsNWidgets(3));
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Personal Auto'), findsOneWidget);
    expect(find.text('Farm & Ranch'), findsOneWidget);
    // Unsupported policy does not show
    expect(find.text(''), findsNothing);
  });

  testWidgets('TFBI-327: Policy List empty state', (tester) async {
    mocktail.when(() => memberSummaryCubit.state).thenReturn(
          MemberSummaryDetailsSuccess(
            memberSummary: MemberSummary(
              policies: [],
            ),
            policyMap: const {},
            error: TfbRequestError(message: 'you have no policies'),
          ),
        );

    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: BlocProvider<MemberSummaryCubit>.value(
          value: memberSummaryCubit,
          child: const PolicyListPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(PolicyListItem), findsNothing);
    expect(find.textContaining('no active policies'), findsOneWidget);
  });
}
