// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paperless_lookup_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaperlessLookupResponse _$PaperlessLookupResponseFromJson(
        Map<String, dynamic> json) =>
    PaperlessLookupResponse(
      policyNumber: json['PolicyNumber'] as String?,
      policyType: json['PolicyType'] as String?,
      policyDescription: json['PolicyDescription'] as String?,
      memberNumber: json['MemberNumber'] as String?,
      memberId: json['MemberId'] as int?,
      memberBeginInitials: json['MemberBeginInitials'] as String?,
      memberEndInitials: json['MemberEndInitials'] as String?,
      memberEmailAddress: json['MemberEmailAddress'] as String?,
      memberPhoneNumber: json['MemberPhoneNumber'] as String?,
      memberEnrollmentType: $enumDecodeNullable(
          _$MemberEnrollmentTypeEnumMap, json['MemberEnrollmentType'],
          unknownValue: MemberEnrollmentType.undefined),
      beginDate: json['BeginDate'] as String?,
      endDate: json['EndDate'] as String?,
      errorMessage: json['ErrorMessage'] as String?,
    );

Map<String, dynamic> _$PaperlessLookupResponseToJson(
        PaperlessLookupResponse instance) =>
    <String, dynamic>{
      'PolicyNumber': instance.policyNumber,
      'PolicyType': instance.policyType,
      'PolicyDescription': instance.policyDescription,
      'MemberNumber': instance.memberNumber,
      'MemberId': instance.memberId,
      'MemberBeginInitials': instance.memberBeginInitials,
      'MemberEndInitials': instance.memberEndInitials,
      'MemberEmailAddress': instance.memberEmailAddress,
      'MemberPhoneNumber': instance.memberPhoneNumber,
      'MemberEnrollmentType':
          _$MemberEnrollmentTypeEnumMap[instance.memberEnrollmentType],
      'BeginDate': instance.beginDate,
      'EndDate': instance.endDate,
      'ErrorMessage': instance.errorMessage,
    };

const _$MemberEnrollmentTypeEnumMap = {
  MemberEnrollmentType.email: 'EML',
  MemberEnrollmentType.text: 'TXT',
  MemberEnrollmentType.both: 'BOTH',
  MemberEnrollmentType.undefined: 'undefined',
};
