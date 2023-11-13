import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/auto_policy/auto_policy_cubit.dart';
import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/models/models.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_document_information_repository.dart';

import '../../../mocks/mock_policy_lookup_client.dart';
import '../../../mocks/mock_tfb_document_information_client.dart';

void main() {
  late TfbDocumentInformationClient mockDocumentInformationClient;

  setUp(() {
    mockDocumentInformationClient = MockTfbDocumentInformationClient();

    registerFallbackValue(testPolicySummary);
  });

  test('[AutoPolicCubit] should start in the [AutoPolicyInitial] state', () {
    expect(
      AutoPolicyCubit(
        documentInformationRepository: TfbDocumentInformationRepository(
          client: mockDocumentInformationClient,
        ),
      ).state,
      isA<AutoPolicyInitial>(),
    );
  });

  blocTest<AutoPolicyCubit, AutoPolicyState>(
    'If the document client [getPersonlSixMonthAutoPolicyAbbreviated] call fails, move to a [AutoPolicyFailure] state',
    build: () => AutoPolicyCubit(
      documentInformationRepository: TfbDocumentInformationRepository(
        client: mockDocumentInformationClient,
      ),
    ),
    setUp: () {
      when(
        () => mockDocumentInformationClient
            .getPersonalSixMonthAutoPolicyAbbreviated(any()),
      ).thenThrow(Exception('ERROR'));
    },
    act: (bloc) => bloc.getPersonalAutoPolicy(testPolicySummary),
    expect: () => [isA<AutoPolicyProcessing>(), isA<AutoPolicyFailure>()],
  );

  blocTest<AutoPolicyCubit, AutoPolicyState>(
    'If the document client [getPersonlSixMonthAutoPolicyAbbreviated] call succeeds, move to a [AutoPolicySuccess] state',
    build: () => AutoPolicyCubit(
      documentInformationRepository: TfbDocumentInformationRepository(
        client: mockDocumentInformationClient,
      ),
    ),
    setUp: () {
      when(
        () => mockDocumentInformationClient
            .getPersonalSixMonthAutoPolicyAbbreviated(any()),
      ).thenAnswer((invocation) => Future.value(testPolicyDetail));
    },
    act: (bloc) => bloc.getPersonalAutoPolicy(testPolicySummary),
    expect: () => [isA<AutoPolicyProcessing>(), isA<AutoPolicySuccess>()],
  );
}

final testPolicySummary = PolicySummary(
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

final testPolicyDetail = MockPolicy.createAutoPolicyDetail();
