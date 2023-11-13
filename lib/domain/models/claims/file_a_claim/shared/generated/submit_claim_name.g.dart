// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../submit_claim_name.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitClaimName _$SubmitClaimNameFromJson(Map<String, dynamic> json) =>
    SubmitClaimName(
      firstName: json['FirstName'] as String?,
      lastName: json['LastName'] as String?,
      suffix: json['Suffix'] as String?,
      displayName: json['DisplayName'] as String?,
    );

Map<String, dynamic> _$SubmitClaimNameToJson(SubmitClaimName instance) =>
    <String, dynamic>{
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'Suffix': instance.suffix,
      'DisplayName': instance.displayName,
    };
