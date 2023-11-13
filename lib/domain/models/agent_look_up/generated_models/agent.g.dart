// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../agent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Agent _$AgentFromJson(Map<String, dynamic> json) => Agent(
      agentCode: json['_agentCode'] as String?,
      agentName: json['_agentName'] as String?,
      countyName: json['_countyName'] as String?,
    );

Map<String, dynamic> _$AgentToJson(Agent instance) => <String, dynamic>{
      '_agentCode': instance.agentCode,
      '_agentName': instance.agentName,
      '_countyName': instance.countyName,
    };
