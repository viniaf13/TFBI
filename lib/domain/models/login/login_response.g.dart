// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      accessToken: json['AccessToken'] as String?,
      agentNumber: json['AgentNumber'] as String?,
      communicationPreferred: json['CommunicationPreferred'] as String?,
      emailVerified: json['EmailVerified'] as String?,
      errorMessage: json['ErrorMessage'] as String?,
      memberEmailAddress: json['MemberEmailAddress'] as String?,
      memberName: json['MemberName'] as String?,
      memberSecondaryName: json['MemberSecondaryName'] as String?,
      passwordResetFlag: json['PasswordResetFlag'] as String?,
      username: json['UserName'] as String?,
      members: (json['Members'] as List<dynamic>?)
          ?.map((e) => LoginMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..sessionCookies = json['sessionCookies'] as String?;

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'AccessToken': instance.accessToken,
      'AgentNumber': instance.agentNumber,
      'CommunicationPreferred': instance.communicationPreferred,
      'EmailVerified': instance.emailVerified,
      'ErrorMessage': instance.errorMessage,
      'MemberEmailAddress': instance.memberEmailAddress,
      'Members': instance.members,
      'MemberName': instance.memberName,
      'MemberSecondaryName': instance.memberSecondaryName,
      'PasswordResetFlag': instance.passwordResetFlag,
      'UserName': instance.username,
      'sessionCookies': instance.sessionCookies,
    };
