// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_email_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateEmailRequest _$UpdateEmailRequestFromJson(Map<String, dynamic> json) =>
    UpdateEmailRequest(
      memberNumber: json['MemberNumber'] as String,
      newUserName: json['NewUserName'] as String,
      oldUserName: json['OldUserName'] as String,
    );

Map<String, dynamic> _$UpdateEmailRequestToJson(UpdateEmailRequest instance) =>
    <String, dynamic>{
      'MemberNumber': instance.memberNumber,
      'NewUserName': instance.newUserName,
      'OldUserName': instance.oldUserName,
    };
