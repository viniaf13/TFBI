// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginMember _$LoginMemberFromJson(Map<String, dynamic> json) => LoginMember(
      lastLoginTimestamp: json['LastLoginTimestamp'] as String,
      memberIDNumber: json['MemberIDNumber'] as int,
      memberNumber: json['MemberNumber'] as String,
    );

Map<String, dynamic> _$LoginMemberToJson(LoginMember instance) =>
    <String, dynamic>{
      'LastLoginTimestamp': instance.lastLoginTimestamp,
      'MemberIDNumber': instance.memberIDNumber,
      'MemberNumber': instance.memberNumber,
    };
