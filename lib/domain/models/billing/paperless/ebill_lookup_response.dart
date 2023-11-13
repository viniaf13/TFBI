// coverage:ignore-file

import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/paperless/member_enrollment_type.dart';

part 'ebill_lookup_response.g.dart';

@JsonSerializable()
class EbillLookupResponse {
  EbillLookupResponse({
    this.policyNumber,
    this.policyType,
    this.policySymbol,
    this.policyDescription,
    this.memberNumber,
    this.memberId,
    this.miraId,
    this.memberBeginInitials,
    this.memberEndInitials,
    this.memberEmailAddress,
    this.memberPhoneNumber,
    this.enrollmentType,
    this.beginDate,
    this.endDate,
    this.errorMessage,
  });

  factory EbillLookupResponse.fromJson(Map<String, dynamic> json) =>
      _$EbillLookupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EbillLookupResponseToJson(this);

  @JsonKey(name: 'PolicyNumber')
  final String? policyNumber;
  @JsonKey(name: 'PolicyType')
  final String? policyType;
  @JsonKey(name: 'PolicySymbol')
  final String? policySymbol;
  @JsonKey(name: 'PolicyDescription')
  final String? policyDescription;
  @JsonKey(name: 'MemberNumber')
  final String? memberNumber;
  @JsonKey(name: 'MemberId')
  final int? memberId;
  @JsonKey(name: 'MiraId')
  final int? miraId;
  @JsonKey(name: 'MemberBeginInitials')
  final String? memberBeginInitials;
  @JsonKey(name: 'MemberEndInitials')
  final String? memberEndInitials;
  @JsonKey(name: 'MemberEmailAddress')
  final String? memberEmailAddress;
  @JsonKey(name: 'MemberPhoneNumber')
  final String? memberPhoneNumber;
  @JsonKey(
    name: 'EnrollmentType',
    unknownEnumValue: MemberEnrollmentType.undefined,
  )
  final MemberEnrollmentType? enrollmentType;
  @JsonKey(name: 'BeginDate')
  final String? beginDate;
  @JsonKey(name: 'EndDate')
  final String? endDate;
  @JsonKey(name: 'ErrorMessage')
  final String? errorMessage;

  EbillLookupResponse copyWith({
    String? policyNumber,
    String? policyType,
    String? policySymbol,
    String? policyDescription,
    String? memberNumber,
    int? memberId,
    int? miraId,
    String? memberBeginInitials,
    String? memberEndInitials,
    String? memberEmailAddress,
    String? memberPhoneNumber,
    MemberEnrollmentType? enrollmentType,
    String? beginDate,
    String? endDate,
    String? errorMessage,
  }) =>
      EbillLookupResponse(
        policyNumber: policyNumber ?? this.policyNumber,
        policyType: policyType ?? this.policyType,
        policySymbol: policySymbol ?? this.policySymbol,
        policyDescription: policyDescription ?? this.policyDescription,
        memberNumber: memberNumber ?? this.memberNumber,
        memberId: memberId ?? this.memberId,
        miraId: miraId ?? this.miraId,
        memberBeginInitials: memberBeginInitials ?? this.memberBeginInitials,
        memberEndInitials: memberEndInitials ?? this.memberEndInitials,
        memberEmailAddress: memberEmailAddress ?? this.memberEmailAddress,
        memberPhoneNumber: memberPhoneNumber ?? this.memberPhoneNumber,
        enrollmentType: enrollmentType ?? this.enrollmentType,
        beginDate: beginDate ?? this.beginDate,
        endDate: endDate ?? this.endDate,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  String toString() {
    String returnStr = '';
    returnStr += 'policyNumber: $policyNumber\n';
    returnStr += 'policyType: $policyType\n';
    returnStr += 'policyDescription: $policyDescription\n';
    returnStr += 'memberNumber: $memberNumber\n';
    returnStr += 'memberId: $memberId\n';
    returnStr += 'miraId: $miraId\n';
    returnStr += 'memberBeginInitials: $memberBeginInitials\n';
    returnStr += 'memberEndInitials: $memberEndInitials\n';
    returnStr += 'memberEmailAddress: $memberEmailAddress\n';
    returnStr += 'memberPhoneNumber: $memberPhoneNumber\n';
    returnStr += 'enrollmentType: $enrollmentType\n';
    returnStr += 'beginDate: $beginDate\n';
    returnStr += 'endDate: $endDate\n';
    returnStr += 'errorMessage: $errorMessage\n';
    return returnStr;
  }
}
