// coverage:ignore-file

import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/paperless/member_enrollment_type.dart';

part 'paperless_lookup_response.g.dart';

@JsonSerializable()
class PaperlessLookupResponse {
  PaperlessLookupResponse({
    this.policyNumber,
    this.policyType,
    this.policyDescription,
    this.memberNumber,
    this.memberId,
    this.memberBeginInitials,
    this.memberEndInitials,
    this.memberEmailAddress,
    this.memberPhoneNumber,
    this.memberEnrollmentType,
    this.beginDate,
    this.endDate,
    this.errorMessage,
  });

  factory PaperlessLookupResponse.fromJson(Map<String, dynamic> json) =>
      _$PaperlessLookupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaperlessLookupResponseToJson(this);

  @JsonKey(name: 'PolicyNumber')
  final String? policyNumber;
  @JsonKey(name: 'PolicyType')
  final String? policyType;
  @JsonKey(name: 'PolicyDescription')
  final String? policyDescription;
  @JsonKey(name: 'MemberNumber')
  final String? memberNumber;
  @JsonKey(name: 'MemberId')
  final int? memberId;
  @JsonKey(name: 'MemberBeginInitials')
  final String? memberBeginInitials;
  @JsonKey(name: 'MemberEndInitials')
  final String? memberEndInitials;
  @JsonKey(name: 'MemberEmailAddress')
  final String? memberEmailAddress;
  @JsonKey(name: 'MemberPhoneNumber')
  final String? memberPhoneNumber;
  @JsonKey(
    name: 'MemberEnrollmentType',
    unknownEnumValue: MemberEnrollmentType.undefined,
  )
  final MemberEnrollmentType? memberEnrollmentType;
  @JsonKey(name: 'BeginDate')
  final String? beginDate;
  @JsonKey(name: 'EndDate')
  final String? endDate;
  @JsonKey(name: 'ErrorMessage')
  final String? errorMessage;

  PaperlessLookupResponse copyWith({
    String? policyNumber,
    String? policyType,
    String? policyDescription,
    String? memberNumber,
    int? memberId,
    String? memberBeginInitials,
    String? memberEndInitials,
    String? memberEmailAddress,
    String? memberPhoneNumber,
    MemberEnrollmentType? memberEnrollmentType,
    String? beginDate,
    String? endDate,
    String? errorMessage,
  }) =>
      PaperlessLookupResponse(
        policyNumber: policyNumber ?? this.policyNumber,
        policyType: policyType ?? this.policyType,
        policyDescription: policyDescription ?? this.policyDescription,
        memberNumber: memberNumber ?? this.memberNumber,
        memberId: memberId ?? this.memberId,
        memberBeginInitials: memberBeginInitials ?? this.memberBeginInitials,
        memberEndInitials: memberEndInitials ?? this.memberEndInitials,
        memberEmailAddress: memberEmailAddress ?? this.memberEmailAddress,
        memberPhoneNumber: memberPhoneNumber ?? this.memberPhoneNumber,
        memberEnrollmentType: memberEnrollmentType ?? this.memberEnrollmentType,
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
    returnStr += 'memberBeginInitials: $memberBeginInitials\n';
    returnStr += 'memberEndInitials: $memberEndInitials\n';
    returnStr += 'memberEmailAddress: $memberEmailAddress\n';
    returnStr += 'memberPhoneNumber: $memberPhoneNumber\n';
    returnStr += 'memberEnrollmentType: $memberEnrollmentType\n';
    returnStr += 'beginDate: $beginDate\n';
    returnStr += 'endDate: $endDate\n';
    returnStr += 'errorMessage: $errorMessage\n';
    return returnStr;
  }
}
