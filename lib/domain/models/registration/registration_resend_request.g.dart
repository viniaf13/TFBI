// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_resend_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationResendRequest _$RegistrationResendRequestFromJson(
        Map<String, dynamic> json) =>
    RegistrationResendRequest(
      communicationOption: json['CommunicationOption'] as String,
      emailAddress: json['EmailAddress'] as String,
      memberNumber: json['MemberNumber'] as String,
      password: json['Password'] as String,
      policyNumber: json['PolicyNumber'] as String,
    );

Map<String, dynamic> _$RegistrationResendRequestToJson(
        RegistrationResendRequest instance) =>
    <String, dynamic>{
      'CommunicationOption': instance.communicationOption,
      'EmailAddress': instance.emailAddress,
      'MemberNumber': instance.memberNumber,
      'Password': instance.password,
      'PolicyNumber': instance.policyNumber,
    };
