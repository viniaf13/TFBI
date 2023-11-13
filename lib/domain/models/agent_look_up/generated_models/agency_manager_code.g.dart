// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../agency_manager_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgencyManagerCode _$AgencyManagerCodeFromJson(Map<String, dynamic> json) =>
    AgencyManagerCode(
      agentCode: json['_agentCode'] as String?,
      errorMessage: json['_errorMessage'],
    );

Map<String, dynamic> _$AgencyManagerCodeToJson(AgencyManagerCode instance) =>
    <String, dynamic>{
      '_agentCode': instance.agentCode,
      '_errorMessage': instance.errorMessage,
    };
