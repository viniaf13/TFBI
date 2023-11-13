// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_verify_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordVerifyResponse _$ForgotPasswordVerifyResponseFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordVerifyResponse(
      errorMessage: json['ErrorMessage'] as String?,
      membershipArray: (json['MembershipArray'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      returnMessage: json['ReturnMessage'] as String?,
    );

Map<String, dynamic> _$ForgotPasswordVerifyResponseToJson(
        ForgotPasswordVerifyResponse instance) =>
    <String, dynamic>{
      'ErrorMessage': instance.errorMessage,
      'MembershipArray': instance.membershipArray,
      'ReturnMessage': instance.returnMessage,
    };
