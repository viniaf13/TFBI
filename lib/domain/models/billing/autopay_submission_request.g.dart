// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autopay_submission_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutopaySubmissionRequest _$AutopaySubmissionRequestFromJson(
        Map<String, dynamic> json) =>
    AutopaySubmissionRequest(
      accountType:
          $enumDecode(_$AutopayAccountTypeEnumMap, json['AccountType']),
      agentId: json['AgentId'] as String,
      bankAccountNumber: json['BankAccountNumber'] as String,
      bankName: json['BankName'] as String,
      bankRoutingNumber: json['BankRoutingNumber'] as String,
      effectiveDate: json['EffectiveDate'] as String,
      insuredEmailAddress: json['InsuredEmailAddress'] as String,
      memberNumber: json['MemberNumber'] as String,
      paymentDate: json['PaymentDate'] as int,
      policyNumber: json['PolicyNumber'] as String,
      policySubType: json['PolicySubType'] as String,
      policyType: json['PolicyType'] as String,
      policyholderName: json['PolicyholderName'] as String,
      requestType: $enumDecode(_$AutopayRequestTypeEnumMap, json['RequestType'],
          unknownValue: AutopayRequestType.unknown),
    );

Map<String, dynamic> _$AutopaySubmissionRequestToJson(
        AutopaySubmissionRequest instance) =>
    <String, dynamic>{
      'AccountType': _$AutopayAccountTypeEnumMap[instance.accountType]!,
      'AgentId': instance.agentId,
      'BankAccountNumber': instance.bankAccountNumber,
      'BankName': instance.bankName,
      'BankRoutingNumber': instance.bankRoutingNumber,
      'EffectiveDate': instance.effectiveDate,
      'InsuredEmailAddress': instance.insuredEmailAddress,
      'MemberNumber': instance.memberNumber,
      'PaymentDate': instance.paymentDate,
      'PolicyNumber': instance.policyNumber,
      'PolicySubType': instance.policySubType,
      'PolicyType': instance.policyType,
      'PolicyholderName': instance.policyholderName,
      'RequestType': _$AutopayRequestTypeEnumMap[instance.requestType]!,
    };

const _$AutopayAccountTypeEnumMap = {
  AutopayAccountType.unknown: '',
  AutopayAccountType.checkings: 'CH',
  AutopayAccountType.savings: 'SA',
};

const _$AutopayRequestTypeEnumMap = {
  AutopayRequestType.unknown: -1,
  AutopayRequestType.enroll: 0,
  AutopayRequestType.update: 1,
  AutopayRequestType.disenroll: 2,
};
