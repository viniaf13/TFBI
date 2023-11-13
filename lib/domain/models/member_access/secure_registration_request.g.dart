// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secure_registration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationRequest _$RegistrationRequestFromJson(Map<String, dynamic> json) =>
    RegistrationRequest(
      communicationOption: json['CommunicationOption'] as String,
      emailAddress: json['EmailAddress'] as String,
      memberNumber: json['MemberNumber'] as String,
      password: json['Password'] as String,
      policyNumber: json['PolicyNumber'] as String,
    );

Map<String, dynamic> _$RegistrationRequestToJson(
        RegistrationRequest instance) =>
    <String, dynamic>{
      'CommunicationOption': instance.communicationOption,
      'EmailAddress': instance.emailAddress,
      'MemberNumber': instance.memberNumber,
      'Password': instance.password,
      'PolicyNumber': instance.policyNumber,
    };
