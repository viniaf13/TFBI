// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_account_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteAccountRequest _$DeleteAccountRequestFromJson(
        Map<String, dynamic> json) =>
    DeleteAccountRequest(
      memberId: json['MemberId'] as int,
      memberInitials: json['MemberInitials'] as String,
      memberNumber: json['MemberNumber'] as String,
    );

Map<String, dynamic> _$DeleteAccountRequestToJson(
        DeleteAccountRequest instance) =>
    <String, dynamic>{
      'MemberId': instance.memberId,
      'MemberInitials': instance.memberInitials,
      'MemberNumber': instance.memberNumber,
    };
