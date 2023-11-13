// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ebill_lookup_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EbillLookupRequest _$EbillLookupRequestFromJson(Map<String, dynamic> json) =>
    EbillLookupRequest(
      memberNumber: json['MemberNumber'] as String?,
      policyNumber: json['PolicyNumber'] as String?,
      policyType: json['PolicyType'] as String?,
    );

Map<String, dynamic> _$EbillLookupRequestToJson(EbillLookupRequest instance) =>
    <String, dynamic>{
      'MemberNumber': instance.memberNumber,
      'PolicyNumber': instance.policyNumber,
      'PolicyType': instance.policyType,
    };
