// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paperless_lookup_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaperlessLookupRequest _$PaperlessLookupRequestFromJson(
        Map<String, dynamic> json) =>
    PaperlessLookupRequest(
      memberNumber: json['MemberNumber'] as String?,
      policyNumber: json['PolicyNumber'] as String?,
      policyType: json['PolicyType'] as String?,
    );

Map<String, dynamic> _$PaperlessLookupRequestToJson(
        PaperlessLookupRequest instance) =>
    <String, dynamic>{
      'MemberNumber': instance.memberNumber,
      'PolicyNumber': instance.policyNumber,
      'PolicyType': instance.policyType,
    };
