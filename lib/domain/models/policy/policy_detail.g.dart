// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PolicyDetail _$PolicyDetailFromJson(Map<String, dynamic> json) => PolicyDetail(
      effectiveDate: json['EffectiveDate'] as String,
      expirationDate: json['ExpirationDate'] as String,
      policyBilling:
          PolicyBilling.fromJson(json['PolicyBilling'] as Map<String, dynamic>),
      policyDescription: json['PolicyDescription'] as String,
      policyNumber: json['PolicyNumber'] as String,
      policySubType: json['PolicySubType'] as String,
      policyType: json['PolicyType'] as String,
      namedInsuredOne: json['NamedInsuredOne'] as String?,
      namedInsuredTwo: json['NamedInsuredTwo'] as String?,
      writingCompanyName: json['WritingCompanyName'] as String?,
    );

Map<String, dynamic> _$PolicyDetailToJson(PolicyDetail instance) =>
    <String, dynamic>{
      'PolicyNumber': instance.policyNumber,
      'PolicyType': instance.policyType,
      'PolicySubType': instance.policySubType,
      'PolicyDescription': instance.policyDescription,
      'EffectiveDate': instance.effectiveDate,
      'ExpirationDate': instance.expirationDate,
      'NamedInsuredOne': instance.namedInsuredOne,
      'NamedInsuredTwo': instance.namedInsuredTwo,
      'WritingCompanyName': instance.writingCompanyName,
      'PolicyBilling': instance.policyBilling,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      json['Address1'] as String,
      json['Address2'] as String?,
      json['Address3'] as String?,
      json['City'] as String,
      json['State'] as String,
      json['ZipCode'] as String,
      json['ZipCode4'] as String?,
      json['ZipCode2'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'Address1': instance.address1,
      'Address2': instance.address2,
      'Address3': instance.address3,
      'City': instance.city,
      'State': instance.state,
      'ZipCode': instance.zipCode,
      'ZipCode4': instance.zipCode4,
      'ZipCode2': instance.zipCode2,
    };

PolicyBilling _$PolicyBillingFromJson(Map<String, dynamic> json) =>
    PolicyBilling(
      json['BillAccountNumber'] as String,
      json['BilledPremiumAmount'] as String,
      json['BillingPlan'] as String,
      json['CurrentAmountDue'] as String,
      json['CurrentPaymentDueDate'] as String,
      json['EbillStatus'] as String,
      json['PastDueAmount'] as String,
      (json['PaymentHistory'] as List<dynamic>?)
          ?.map((e) => PaymentHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['GrossPremiumAmount'] as String?,
      json['TotalDiscounts'] as String?,
      json['TheftFee'] as String?,
    );

Map<String, dynamic> _$PolicyBillingToJson(PolicyBilling instance) =>
    <String, dynamic>{
      'BillAccountNumber': instance.billAccountNumber,
      'BilledPremiumAmount': instance.billedPremiumAmount,
      'BillingPlan': instance.billingPlan,
      'CurrentAmountDue': instance.currentAmountDue,
      'CurrentPaymentDueDate': instance.currentPaymentDueDate,
      'EbillStatus': instance.eBillStatus,
      'PastDueAmount': instance.pastDueAmount,
      'PaymentHistory': instance.paymentHistory,
      'GrossPremiumAmount': instance.grossPremiumAmount,
      'TotalDiscounts': instance.totalDiscounts,
      'TheftFee': instance.theftFee,
    };
