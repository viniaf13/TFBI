// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
part of '../submit_claim_reporter_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitClaimReporterTypes _$SubmitClaimReporterTypesFromJson(
        Map<String, dynamic> json) =>
    SubmitClaimReporterTypes(
      key: json['Key'] as String?,
      value: $enumDecodeNullable(_$ReporterTypesEnumEnumMap, json['Value'],
          unknownValue: ReporterTypesEnum.undefined),
    );

Map<String, dynamic> _$SubmitClaimReporterTypesToJson(
        SubmitClaimReporterTypes instance) =>
    <String, dynamic>{
      'Key': instance.key,
      'Value': _$ReporterTypesEnumEnumMap[instance.value],
    };

const _$ReporterTypesEnumEnumMap = {
  ReporterTypesEnum.insured: 'Insured',
  ReporterTypesEnum.agent: 'Insureds Agent',
  ReporterTypesEnum.claimant: 'Claimant',
  ReporterTypesEnum.other: 'Other',
  ReporterTypesEnum.undefined: 'undefined',
};
