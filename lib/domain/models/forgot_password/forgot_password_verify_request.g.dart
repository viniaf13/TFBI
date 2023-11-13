// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_verify_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordVerifyRequest _$ForgotPasswordVerifyRequestFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordVerifyRequest(
      emailAddress: json['EmailAddress'] as String,
      verificationCode: json['VerificationCode'] as String,
    );

Map<String, dynamic> _$ForgotPasswordVerifyRequestToJson(
        ForgotPasswordVerifyRequest instance) =>
    <String, dynamic>{
      'EmailAddress': instance.emailAddress,
      'VerificationCode': instance.verificationCode,
    };
