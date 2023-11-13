import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/widgets/billing_member_summary_consumer.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/billing_page.dart';
import 'package:txfb_insurance_flutter/device/environment/environment.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/member_summary.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_dropshadow_scroll_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import '../../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../../mocks/mock_member_summary.dart';
import '../../../mocks/mock_policy_lookup_client.dart';
import '../../../mocks/mock_tfb_navigator.dart';
import '../../../widgets/tfb_widget_tester.dart';

void main() {
  final MemberSummaryCubit mockMemberSummaryCubit = MockMemberSummaryCubit();
  final mockStatusBarScrollCubit = MockStatusBarScrollCubit();

  setUpAll(() {
    registerFallbackValue(MemberSummaryInitial());
    registerFallbackValue(Uri());
  });

  setUp(() {
    when(() => mockMemberSummaryCubit.state).thenReturn(
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
    when(() => mockStatusBarScrollCubit.state)
        .thenReturn(const StatusBarScrollInitial(''));
  });

  testWidgets('BillingPage loads and displays correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TfbWidgetTester(
          mockStatusBarScrollCubit: mockStatusBarScrollCubit,
          mockMemberSummaryCubit: mockMemberSummaryCubit,
          mockEnvironment: TfbEnvironmentStage(),
          child: const BillingPage(),
        ),
      ),
    );

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(TfbDropShadowScrollWidget), findsOneWidget);
    expect(find.byType(CustomScrollView), findsOneWidget);
    expect(find.text('Billing'), findsNWidgets(2));
    expect(find.byType(BillingMemberSummaryConsumer), findsOneWidget);
    expect(
      find.widgetWithText(
        TfbFilledButton,
        AppLocalizationsEn().makeAMembershipPayment,
      ),
      findsNWidgets(1),
    );
  });

  testWidgets('Make a membership payment navigates to web viewer page',
      (tester) async {
    final mockNavigator = MockTfbNavigator();

    when(
      () => mockNavigator.pushToWebViewerPage(any()),
    ).thenAnswer((_) => Future<Object?>.value());

    await tester.pumpWidget(
      TfbWidgetTester(
        mockEnvironment: TfbEnvironmentStage(),
        mockNavigator: mockNavigator,
        child: BlocProvider.value(
          value: mockMemberSummaryCubit,
          child: const CustomScrollView(
            slivers: [
              BillingMemberSummaryConsumer(),
            ],
          ),
        ),
      ),
    );

    final finderMakeAMembershipPayment = find
        .widgetWithText(
          TfbFilledButton,
          AppLocalizationsEn().makeAMembershipPayment,
        )
        .last;

    await tester.tap(finderMakeAMembershipPayment);
    await tester.pumpAndSettle();

    verify(
      () => mockNavigator.pushToWebViewerPage(any()),
    ).called(1);
  });
}
