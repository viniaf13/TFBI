import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/autopay/autopay_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/paperless_lookup/paperless_lookup_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing_document_list/billing_document_list_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/tfb_single_request_cubit/tfb_single_request_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/paperless_notification_preferences.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/billing.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/billing_document_list/billing_document_list_container.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/billing_payment_list/billing_payment_list_container.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_card.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/billing_list_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/paperless/paperless_lookup_response.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/member_summary.dart';

import '../../../mocks/bloc/mock_auto_play_bloc.dart';
import '../../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../../mocks/mock_member_summary.dart';
import '../../../widgets/tfb_widget_tester.dart';
import '../../cubits/billing/paperless_lookup/mock_paperless_lookup_cubit.dart';
import '../../cubits/billing_document_list/billing_document_list_cubit.dart';

void main() {
  final MemberSummaryCubit memberSummaryCubit = MockMemberSummaryCubit();
  final BillingDocumentListCubit billingDocumentListCubit =
      MockBillingDocumentListCubit();
  final PaperlessLookupCubit paperlessLookupCubit = MockPaperlessLookupCubit();
  final AutopayBloc autopayBloc = MockAutoPayBloc();
  final mockStatusBarScrollCubit = MockStatusBarScrollCubit();
  setUp(() async {
    when(() => memberSummaryCubit.state).thenReturn(
      MemberSummaryDetailsSuccess(
        memberSummary: MemberSummary(
          policies: [_policySummary],
        ),
        policyMap: _policyMap,
      ),
    );

    when(() => billingDocumentListCubit.state).thenReturn(
      TfbSingleRequestSuccess(
        response: _billingListResponse,
      ),
    );

    when(() => paperlessLookupCubit.state).thenReturn(
      PaperlessLookupSuccessState(
        response: _paperlessLookupResponse,
      ),
    );

    when(() => autopayBloc.state).thenReturn(AutopayCancelled());

    when(() => mockStatusBarScrollCubit.state)
        .thenReturn(const StatusBarScrollInitial(''));
  });
  testWidgets(
      'On successful policy summary and policy detail calls, the billing details page shows the correct elements',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: memberSummaryCubit),
            BlocProvider.value(value: billingDocumentListCubit),
            BlocProvider.value(value: paperlessLookupCubit),
            BlocProvider.value(value: autopayBloc),
          ],
          child: BillingDetailsPage(policy: _policySummary),
        ),
      ),
    );

    expect(find.byType(PolicyDetailCard), findsOneWidget);
    expect(find.byType(BillingDocumentListContainer), findsOneWidget);
    expect(find.byType(BillingPaymentListContainer), findsOneWidget);
    expect(
      find.byType(PaperlessNotificationPreferences, skipOffstage: false),
      findsOneWidget,
    );
  });

  testWidgets('Test if the snackbar appears when auto-pay is canceled',
      (tester) async {
    whenListen(
      autopayBloc,
      Stream.value(
        mockAutopayCancelled,
      ),
      initialState: mockAutopayInitial,
    );
    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: memberSummaryCubit),
            BlocProvider.value(value: billingDocumentListCubit),
            BlocProvider.value(value: paperlessLookupCubit),
            BlocProvider.value(value: autopayBloc),
          ],
          child: BillingDetailsPage(policy: _policySummary),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final textMatcher = AppLocalizationsEn().autoPayEnrollCancelledSuccess;
    final finderSnackBar = find.text(textMatcher);
    expect(finderSnackBar, findsOneWidget);
  });

  testWidgets('Test if the snackbar appears when auto-pay is discontinued',
      (tester) async {
    whenListen(
      autopayBloc,
      Stream.value(
        mockAutopayDiscontinueSuccess,
      ),
      initialState: mockAutopayInitial,
    );
    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: memberSummaryCubit),
            BlocProvider.value(value: billingDocumentListCubit),
            BlocProvider.value(value: paperlessLookupCubit),
            BlocProvider.value(value: autopayBloc),
          ],
          child: BillingDetailsPage(policy: _policySummary),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final textMatcher = AppLocalizationsEn().discontinueAutopaySuccessMsg;
    final finderSnackBar = find.text(textMatcher);
    expect(finderSnackBar, findsOneWidget);
  });

  testWidgets('Test if the snackbar appears when member summary fail',
      (tester) async {
    whenListen(
      memberSummaryCubit,
      Stream.value(
        mockMemberSummaryFailure,
      ),
      initialState: mockMemberSummaryInitial,
    );
    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: memberSummaryCubit),
            BlocProvider.value(value: billingDocumentListCubit),
            BlocProvider.value(value: paperlessLookupCubit),
            BlocProvider.value(value: autopayBloc),
          ],
          child: BillingDetailsPage(policy: _policySummary),
        ),
      ),
    );
    await tester.pump();
    final textMatcher = mockMemberSummaryFailure.error.message;
    final finderSnackBar = find.text(textMatcher);
    expect(finderSnackBar, findsOneWidget);
  });

  testWidgets(
      "Test if the snackbar doens't appear when member summary the state is MemberSummaryDetailsSuccess",
      (tester) async {
    whenListen(
      memberSummaryCubit,
      Stream.value(
        mockMemberSummaryDetailsSuccess,
      ),
      initialState: mockMemberSummaryInitial,
    );
    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: memberSummaryCubit),
            BlocProvider.value(value: billingDocumentListCubit),
            BlocProvider.value(value: paperlessLookupCubit),
            BlocProvider.value(value: autopayBloc),
          ],
          child: BillingDetailsPage(policy: _policySummary),
        ),
      ),
    );
    await tester.pump();
    final textMatcher = AppLocalizationsEn().somethingWentWrong;
    final finderSnackBar = find.text(textMatcher);
    expect(finderSnackBar, findsNothing);
  });

  testWidgets(
      'Test if the snackbar appears when member summary the state is MemberSummaryDetailsSuccess and has a error',
      (tester) async {
    whenListen(
      memberSummaryCubit,
      Stream.value(
        mockMemberSummaryDetailsSuccessWithError,
      ),
      initialState: mockMemberSummaryInitial,
    );
    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: memberSummaryCubit),
            BlocProvider.value(value: billingDocumentListCubit),
            BlocProvider.value(value: paperlessLookupCubit),
            BlocProvider.value(value: autopayBloc),
          ],
          child: BillingDetailsPage(policy: _policySummary),
        ),
      ),
    );
    await tester.pump();
    final textMatcher = AppLocalizationsEn().somethingWentWrong;
    final finderSnackBar = find.text(textMatcher);
    expect(finderSnackBar, findsOneWidget);
  });
}

final mockMemberSummaryDetailsSuccess = MemberSummaryDetailsSuccess(
  memberSummary: MemberSummary(
    policies: const [],
  ),
  policyMap: _policyMap,
);
final _billingListResponse = [
  BillingListMetadata(
    date: '2023-10-10',
    documentId: 'documentId',
    formDescription: 'formDescription',
    labelDescription: 'labelDescription',
    pageNumber: 1,
    versionId: '12314',
  ),
];

final _policyMap = {
  _policySummary.policyNumber: PolicyDetail(
    effectiveDate: '2023-10-10',
    expirationDate: '2023-10-10',
    policyBilling: PolicyBilling(
      'billAccountNumber',
      'billedPremiumAmount',
      'billingPlan',
      'currentAmountDue',
      'currentPaymentDueDate',
      'eBillStatus',
      'pastDueAmount',
      [],
      'grossPremiumAmount',
      'totalDiscounts',
      'theftFee',
    ),
    policyDescription: 'policyDescription',
    policyNumber: 'policyNumber',
    policySubType: 'policySubType',
    policyType: 'policyType',
  ),
};

final _policySummary = PolicySummary(
  policyNumber: '1234',
  memberNumber: '1234',
  policyType: PolicyType.agAdvantage,
  policySubType: '1',
  policySymbol: 'SM',
  policyDescription: 'test',
  policyStatus: '',
  billingStatus: '',
  billAccountNumber: '',
  contractNumber: '',
  masterAccountNumber: '',
  policyEffectiveDate: '2023-10-10',
  policyExpirationDate: '2023-10-10',
  policyMinimumAmountDue: '',
  policyMaximumAmountDue: 'policyMaximumAmountDue',
  policyPastDueAmount: 'policyPastDueAmount',
  policyNSFAmount: 'policyNSFAmount',
  policyDueDate: '2023-10-10',
  policyInsuredName: 'policyInsuredName',
  paymentRestriction: 'paymentRestriction',
  policyHolderUrl: 'policyHolderUrl',
  policyIDCardFlag: 'policyIDCardFlag',
  roadsideAssistanceCardFlag: 'roadsideAssistanceCardFlag',
  policyRecurringFlag: RecurringFlag.enrolled,
  policyRecurringStatus: RecurringStatus.active,
  policyLinkFlag: 'policyLinkFlag',
  policyPayableFlag: 'policyPayableFlag',
  policyPremiumFinanceFlag: 'policyPremiumFinanceFlag',
  eBillFlag: 'eBillFlag',
  paperlessFlag: 'paperlessFlag',
  laurusFlag: 'laurusFlag',
  accountBillEligibleFlag: 'accountBillEligibleFlag',
  agentCode: 'agentCode',
);

final _paperlessLookupResponse = PaperlessLookupResponse(
  memberEmailAddress: 'memberEmailAddress',
);
