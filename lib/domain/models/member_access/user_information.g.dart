// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInformation _$UserInformationFromJson(Map<String, dynamic> json) =>
    UserInformation(
      accountCreateDate: json['AccountCreateDate'] as String,
      communicationOption: json['CommunicationOption'] as String,
      emailAddress: json['EmailAddress'] as String,
      emailVerificationIndicator: json['EmailVerificationIndicator'] as String,
      insuredId: json['InsuredId'] as int,
      lastLoginDate: json['LastLoginDate'] as String,
      memberNumber: json['MemberNumber'] as String,
      passwordResetIndicator: json['PasswordResetIndicator'] as String,
      pendingEmailChange: json['PendingEmailChange'] as String,
      userName: json['UserName'] as String,
    );

Map<String, dynamic> _$UserInformationToJson(UserInformation instance) =>
    <String, dynamic>{
      'AccountCreateDate': instance.accountCreateDate,
      'CommunicationOption': instance.communicationOption,
      'EmailAddress': instance.emailAddress,
      'EmailVerificationIndicator': instance.emailVerificationIndicator,
      'InsuredId': instance.insuredId,
      'LastLoginDate': instance.lastLoginDate,
      'MemberNumber': instance.memberNumber,
      'PasswordResetIndicator': instance.passwordResetIndicator,
      'PendingEmailChange': instance.pendingEmailChange,
      'UserName': instance.userName,
    };
