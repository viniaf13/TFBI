// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
part of '../submit_claim_reporter_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReporterInformation _$ReporterInformationFromJson(Map<String, dynamic> json) =>
    ReporterInformation(
      name: json['name'] as String?,
      reporterType: json['type'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      phoneType: json['phoneType'] as String?,
      emailAddress: json['emailAddress'] as String?,
      reportingSource: json['reportingSource'] as int?,
    );

Map<String, dynamic> _$ReporterInformationToJson(
        ReporterInformation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.reporterType,
      'phoneNumber': instance.phoneNumber,
      'phoneType': instance.phoneType,
      'emailAddress': instance.emailAddress,
      'reportingSource': instance.reportingSource,
    };
