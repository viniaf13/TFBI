// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_verification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailVerificationResponse _$EmailVerificationResponseFromJson(
        Map<String, dynamic> json) =>
    EmailVerificationResponse(
      emailUpdate: json['EmailUpdate'] as String,
      errorMessage: json['ErrorMessage'] as String?,
      returnMessage: json['ReturnMessage'] as String,
      verified: json['Verified'] as String,
    );

Map<String, dynamic> _$EmailVerificationResponseToJson(
        EmailVerificationResponse instance) =>
    <String, dynamic>{
      'EmailUpdate': instance.emailUpdate,
      'ErrorMessage': instance.errorMessage,
      'ReturnMessage': instance.returnMessage,
      'Verified': instance.verified,
    };
