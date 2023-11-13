// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_member_secure_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateMemberSecurePasswordRequest _$UpdateMemberSecurePasswordRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateMemberSecurePasswordRequest(
      memberId: json['MemberId'] as int,
      membershipArray: (json['MembershipArray'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      newPassword: json['NewPassword'] as String,
      userName: json['UserName'] as String,
    );

Map<String, dynamic> _$UpdateMemberSecurePasswordRequestToJson(
        UpdateMemberSecurePasswordRequest instance) =>
    <String, dynamic>{
      'MemberId': instance.memberId,
      'MembershipArray': instance.membershipArray,
      'NewPassword': instance.newPassword,
      'UserName': instance.userName,
    };
