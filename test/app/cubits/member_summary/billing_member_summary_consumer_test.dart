import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/widgets/billing_member_summary_consumer.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/policies_list/policy_list_item.dart';
import 'package:txfb_insurance_flutter/device/environment/environment.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/member_summary.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_padding.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import '../../../mocks/mock_member_summary.dart';
import '../../../widgets/tfb_widget_tester.dart';

final mockPolicy = PolicySummary(
  policyNumber: 'policyNumber',
  memberNumber: 'memberNumber',
  policyType: PolicyType.txPersonalAuto,
  policySubType: 'policySubType',
  policySymbol: 'policySymbol',
  policyDescription: 'policyDescription',
  policyStatus: PolicyStatus.active.value,
  billingStatus: 'billingStatus',
  billAccountNumber: 'billAccountNumber',
  contractNumber: 'contractNumber',
  masterAccountNumber: 'masterAccountNumber',
  policyEffectiveDate: 'policyEffectiveDate',
  policyExpirationDate: 'policyExpirationDate',
  policyMinimumAmountDue: 'policyMinimumAmountDue',
  policyMaximumAmountDue: 'policyMaximumAmountDue',
  policyPastDueAmount: 'policyPastDueAmount',
  policyNSFAmount: 'policyNSFAmount',
  policyDueDate: 'policyDueDate',
  policyInsuredName: 'policyInsuredName',
  paymentRestriction: 'paymentRestriction',
  policyHolderUrl: 'policyHolderUrl',
  policyIDCardFlag: 'policyIDCardFlag',
  roadsideAssistanceCardFlag: 'roadsideAssistanceCardFlag',
  policyRecurringFlag: RecurringFlag.enrolled,
  policyRecurringStatus: RecurringStatus.undefined,
  policyLinkFlag: 'policyLinkFlag',
  policyPayableFlag: 'policyPayableFlag',
  policyPremiumFinanceFlag: 'policyPremiumFinanceFlag',
  eBillFlag: 'eBillFlag',
  paperlessFlag: 'paperlessFlag',
  laurusFlag: 'laurusFlag',
  accountBillEligibleFlag: 'accountBillEligibleFlag',
  agentCode: 'agentCode',
);

void main() {
  final MemberSummaryCubit mockMemberSummaryCubit = MockMemberSummaryCubit();

  setUpAll(() {
    registerFallbackValue(MemberSummaryInitial());
  });

  testWidgets(
      'Should show loading overlay when MemberSummaryProcessing state is emitted',
      (WidgetTester tester) async {
    when(() => mockMemberSummaryCubit.state)
        .thenReturn(const MemberSummaryProcessing(isPullToRefresh: false));

    await tester.pumpWidget(
      TfbWidgetTester(
        mockEnvironment: TfbEnvironmentStage(),
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
    expect(find.byType(TfbBrandLoadingIcon), findsOneWidget);
  });

  testWidgets(
      'Should show PolicyListItem when MemberSummarySuccess with policies is emitted',
      (WidgetTester tester) async {
    when(() => mockMemberSummaryCubit.state).thenReturn(
      MemberSummarySuccess(
        memberSummary: MemberSummary(policies: [mockPolicy, mockPolicy]),
      ),
    );

    await tester.pumpWidget(
      TfbWidgetTester(
        mockEnvironment: TfbEnvironmentStage(),
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
    expect(find.byType(PolicyListItem), findsNWidgets(2));
    expect(
      find.widgetWithText(
        TfbFilledButton,
        AppLocalizationsEn().makeAMembershipPayment,
      ),
      findsNWidgets(1),
    );
  });

  testWidgets('Should show error message when MemberSummaryFailure is emitted',
      (WidgetTester tester) async {
    when(() => mockMemberSummaryCubit.state).thenReturn(
      MemberSummaryFailure(
        error: TfbRequestError(message: 'An error occurred'),
      ),
    );

    await tester.pumpWidget(
      TfbWidgetTester(
        mockEnvironment: TfbEnvironmentStage(),
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
    expect(find.byType(TextWithPadding), findsOneWidget);
  });
}
