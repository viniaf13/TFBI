import 'package:plugin_haven/environment/environment_provider.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/payment_dialog/payment_dialog_button.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/payment_dialog/make_payment_dialog.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('MakePaymentDialog shows the correct widgets', (tester) async {
    await tester.pumpWidget(
      EnvironmentProvider(
        defaultEnvironment: TfbEnvironmentDev(),
        child: TfbWidgetTester(
          child: MakePaymentDialog(policySummary: _testPolicySummary),
        ),
      ),
    );

    expect(find.textContaining('Make a Payment'), findsOneWidget);
    expect(find.byType(PaymentDialogButton), findsNWidgets(2));
    expect(find.byType(IconButton), findsOneWidget);
  });
}

final _testPolicySummary = PolicySummary(
  policyNumber: 'policyNumber',
  memberNumber: 'memberNumber',
  policyType: PolicyType.homeowners,
  policySubType: '1',
  policySymbol: 'policySymbol',
  policyDescription: 'policyDescription',
  policyStatus: 'policyStatus',
  billingStatus: 'billingStatus',
  billAccountNumber: 'billAccountNumber',
  contractNumber: 'contractNumber',
  masterAccountNumber: '',
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
