// coverage:ignore-file
import 'package:json_annotation/json_annotation.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/member.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/member_address.dart';

part 'secure_registration_response.g.dart';

@JsonSerializable()
class RegistrationResponse {
  RegistrationResponse({
    this.accessToken,
    this.agentNumber,
    this.communicationPreferred,
    this.emailVerified,
    this.errorMessage,
    this.memberAddress,
    this.memberEmailAddress,
    this.memberName,
    this.memberSecondaryName,
    this.members,
    this.passwordResetFlag,
    this.userName,
  });

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) =>
      _$RegistrationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationResponseToJson(this);

  @JsonKey(name: 'AccessToken')
  final String? accessToken;
  @JsonKey(name: 'AgentNumber')
  final String? agentNumber;
  @JsonKey(name: 'CommunicationPreferred')
  final String? communicationPreferred;
  @JsonKey(name: 'EmailVerified')
  final String? emailVerified;
  @JsonKey(name: 'ErrorMessage')
  final String? errorMessage;
  @JsonKey(name: 'MemberAddress')
  final MemberAddress? memberAddress;
  @JsonKey(name: 'MemberEmailAddress')
  final String? memberEmailAddress;
  @JsonKey(name: 'MemberName')
  final String? memberName;
  @JsonKey(name: 'MemberSecondaryName')
  final String? memberSecondaryName;
  @JsonKey(name: 'Members')
  final List<Member>? members;
  @JsonKey(name: 'PasswordResetFlag')
  final String? passwordResetFlag;
  @JsonKey(name: 'UserName')
  final String? userName;
}
