// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secure_registration_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationResponse _$RegistrationResponseFromJson(
        Map<String, dynamic> json) =>
    RegistrationResponse(
      accessToken: json['AccessToken'] as String?,
      agentNumber: json['AgentNumber'] as String?,
      communicationPreferred: json['CommunicationPreferred'] as String?,
      emailVerified: json['EmailVerified'] as String?,
      errorMessage: json['ErrorMessage'] as String?,
      memberAddress: json['MemberAddress'] == null
          ? null
          : MemberAddress.fromJson(
              json['MemberAddress'] as Map<String, dynamic>),
      memberEmailAddress: json['MemberEmailAddress'] as String?,
      memberName: json['MemberName'] as String?,
      memberSecondaryName: json['MemberSecondaryName'] as String?,
      members: (json['Members'] as List<dynamic>?)
          ?.map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
      passwordResetFlag: json['PasswordResetFlag'] as String?,
      userName: json['UserName'] as String?,
    );

Map<String, dynamic> _$RegistrationResponseToJson(
        RegistrationResponse instance) =>
    <String, dynamic>{
      'AccessToken': instance.accessToken,
      'AgentNumber': instance.agentNumber,
      'CommunicationPreferred': instance.communicationPreferred,
      'EmailVerified': instance.emailVerified,
      'ErrorMessage': instance.errorMessage,
      'MemberAddress': instance.memberAddress,
      'MemberEmailAddress': instance.memberEmailAddress,
      'MemberName': instance.memberName,
      'MemberSecondaryName': instance.memberSecondaryName,
      'Members': instance.members,
      'PasswordResetFlag': instance.passwordResetFlag,
      'UserName': instance.userName,
    };
