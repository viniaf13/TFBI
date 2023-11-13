// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      lastLoginTimestamp: json['LastLoginTimestamp'] as String?,
      memberIdNumber: json['MemberIDNumber'] as int?,
      memberNumber: json['MemberNumber'] as String?,
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'LastLoginTimestamp': instance.lastLoginTimestamp,
      'MemberIDNumber': instance.memberIdNumber,
      'MemberNumber': instance.memberNumber,
    };
