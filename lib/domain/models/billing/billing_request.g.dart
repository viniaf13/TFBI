// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillingRequest _$BillingRequestFromJson(Map<String, dynamic> json) =>
    BillingRequest(
      policyNumber: json['PolicyNumber'] as String,
      policyType: json['PolicyType'] as String,
      policySubtype: json['PolicySubType'] as String,
      locationType: json['LocationType'] as String,
    );

Map<String, dynamic> _$BillingRequestToJson(BillingRequest instance) =>
    <String, dynamic>{
      'PolicyNumber': instance.policyNumber,
      'PolicyType': instance.policyType,
      'PolicySubType': instance.policySubtype,
      'LocationType': instance.locationType,
    };
