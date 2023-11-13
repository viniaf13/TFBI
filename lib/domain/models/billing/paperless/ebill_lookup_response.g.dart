// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ebill_lookup_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EbillLookupResponse _$EbillLookupResponseFromJson(Map<String, dynamic> json) =>
    EbillLookupResponse(
      policyNumber: json['PolicyNumber'] as String?,
      policyType: json['PolicyType'] as String?,
      policySymbol: json['PolicySymbol'] as String?,
      policyDescription: json['PolicyDescription'] as String?,
      memberNumber: json['MemberNumber'] as String?,
      memberId: json['MemberId'] as int?,
      miraId: json['MiraId'] as int?,
      memberBeginInitials: json['MemberBeginInitials'] as String?,
      memberEndInitials: json['MemberEndInitials'] as String?,
      memberEmailAddress: json['MemberEmailAddress'] as String?,
      memberPhoneNumber: json['MemberPhoneNumber'] as String?,
      enrollmentType: $enumDecodeNullable(
          _$MemberEnrollmentTypeEnumMap, json['EnrollmentType'],
          unknownValue: MemberEnrollmentType.undefined),
      beginDate: json['BeginDate'] as String?,
      endDate: json['EndDate'] as String?,
      errorMessage: json['ErrorMessage'] as String?,
    );

Map<String, dynamic> _$EbillLookupResponseToJson(
        EbillLookupResponse instance) =>
    <String, dynamic>{
      'PolicyNumber': instance.policyNumber,
      'PolicyType': instance.policyType,
      'PolicySymbol': instance.policySymbol,
      'PolicyDescription': instance.policyDescription,
      'MemberNumber': instance.memberNumber,
      'MemberId': instance.memberId,
      'MiraId': instance.miraId,
      'MemberBeginInitials': instance.memberBeginInitials,
      'MemberEndInitials': instance.memberEndInitials,
      'MemberEmailAddress': instance.memberEmailAddress,
      'MemberPhoneNumber': instance.memberPhoneNumber,
      'EnrollmentType': _$MemberEnrollmentTypeEnumMap[instance.enrollmentType],
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
