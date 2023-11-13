// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PolicySummary _$PolicySummaryFromJson(Map<String, dynamic> json) =>
    PolicySummary(
      policyNumber: json['PolicyNumber'] as String,
      memberNumber: json['MemberNumber'] as String,
      policyType: $enumDecode(_$PolicyTypeEnumMap, json['PolicyType'],
          unknownValue: PolicyType.unsupportedPolicy),
      policySubType: json['PolicySubType'] as String,
      policySymbol: json['PolicySymbol'] as String,
      policyDescription: json['PolicyDescription'] as String,
      policyStatus: json['PolicyStatus'] as String,
      billingStatus: json['BillingStatus'] as String,
      billAccountNumber: json['BillAccountNumber'] as String,
      contractNumber: json['ContractNumber'] as String,
      masterAccountNumber: json['MasterAccountNumber'] as String,
      policyEffectiveDate: json['PolicyEffectiveDate'] as String,
      policyExpirationDate: json['PolicyExpirationDate'] as String,
      policyMinimumAmountDue: json['PolicyMinimumAmountDue'] as String,
      policyMaximumAmountDue: json['PolicyMaximumAmountDue'] as String,
      policyPastDueAmount: json['PolicyPastDueAmount'] as String,
      policyNSFAmount: json['PolicyNSFAmount'] as String,
      policyDueDate: json['PolicyDueDate'] as String,
      policyInsuredName: json['PolicyInsuredName'] as String,
      paymentRestriction: json['PaymentRestriction'] as String,
      policyHolderUrl: json['PolicyHolderUrl'] as String,
      policyIDCardFlag: json['PolicyIDCardFlag'] as String,
      roadsideAssistanceCardFlag: json['RoadsideAssistanceCardFlag'] as String,
      policyRecurringFlag: $enumDecode(
          _$RecurringFlagEnumMap, json['PolicyRecurringFlag'],
          unknownValue: RecurringFlag.undefined),
      policyRecurringStatus: $enumDecode(
          _$RecurringStatusEnumMap, json['PolicyRecurringStatus'],
          unknownValue: RecurringStatus.undefined),
      policyLinkFlag: json['PolicyLinkFlag'] as String,
      policyPayableFlag: json['PolicyPayableFlag'] as String,
      policyPremiumFinanceFlag: json['PolicyPremiumFinanceFlag'] as String,
      eBillFlag: json['EBillFlag'] as String,
      paperlessFlag: json['PaperlessFlag'] as String,
      laurusFlag: json['LaurusFlag'] as String,
      accountBillEligibleFlag: json['AccountBillEligibleFlag'] as String,
      agentCode: json['AgentCode'] as String?,
    );

Map<String, dynamic> _$PolicySummaryToJson(PolicySummary instance) =>
    <String, dynamic>{
      'PolicyNumber': instance.policyNumber,
      'MemberNumber': instance.memberNumber,
      'PolicyType': _$PolicyTypeEnumMap[instance.policyType]!,
      'PolicySubType': instance.policySubType,
      'PolicySymbol': instance.policySymbol,
      'PolicyDescription': instance.policyDescription,
      'PolicyStatus': instance.policyStatus,
      'BillingStatus': instance.billingStatus,
      'BillAccountNumber': instance.billAccountNumber,
      'ContractNumber': instance.contractNumber,
      'MasterAccountNumber': instance.masterAccountNumber,
      'PolicyEffectiveDate': instance.policyEffectiveDate,
      'PolicyExpirationDate': instance.policyExpirationDate,
      'PolicyMinimumAmountDue': instance.policyMinimumAmountDue,
      'PolicyMaximumAmountDue': instance.policyMaximumAmountDue,
      'PolicyPastDueAmount': instance.policyPastDueAmount,
      'PolicyNSFAmount': instance.policyNSFAmount,
      'PolicyDueDate': instance.policyDueDate,
      'PolicyInsuredName': instance.policyInsuredName,
      'PaymentRestriction': instance.paymentRestriction,
      'PolicyHolderUrl': instance.policyHolderUrl,
      'PolicyIDCardFlag': instance.policyIDCardFlag,
      'RoadsideAssistanceCardFlag': instance.roadsideAssistanceCardFlag,
      'PolicyRecurringFlag':
          _$RecurringFlagEnumMap[instance.policyRecurringFlag]!,
      'PolicyRecurringStatus':
          _$RecurringStatusEnumMap[instance.policyRecurringStatus]!,
      'PolicyLinkFlag': instance.policyLinkFlag,
      'PolicyPayableFlag': instance.policyPayableFlag,
      'PolicyPremiumFinanceFlag': instance.policyPremiumFinanceFlag,
      'EBillFlag': instance.eBillFlag,
      'PaperlessFlag': instance.paperlessFlag,
      'LaurusFlag': instance.laurusFlag,
      'AccountBillEligibleFlag': instance.accountBillEligibleFlag,
      'AgentCode': instance.agentCode,
    };

const _$PolicyTypeEnumMap = {
  PolicyType.agAdvantage: 'AA',
  PolicyType.homeowners: 'HT',
  PolicyType.inlandMarine: 'PF',
  PolicyType.lifeAndEndowment: 'LI',
  PolicyType.txPersonalAuto: 'SM',
  PolicyType.umbrella: 'UM',
  PolicyType.unsupportedPolicy: '',
};

const _$RecurringFlagEnumMap = {
  RecurringFlag.enrolled: 'Y',
  RecurringFlag.notEnrolled: 'N',
  RecurringFlag.undefined: 'undefined',
};

const _$RecurringStatusEnumMap = {
  RecurringStatus.active: 'ACT',
  RecurringStatus.deactivated: 'DAC',
  RecurringStatus.preNoteSent: 'PNE',
  RecurringStatus.preNoteSetup: 'PNS',
  RecurringStatus.reactivated: 'RAC',
  RecurringStatus.reactivationReinstate: 'RAI',
  RecurringStatus.reactivationReissue: 'RAR',
  RecurringStatus.preNoteSent2: 'SNT',
  RecurringStatus.notEnrolled: 'n/a',
  RecurringStatus.undefined: 'undefined',
};
