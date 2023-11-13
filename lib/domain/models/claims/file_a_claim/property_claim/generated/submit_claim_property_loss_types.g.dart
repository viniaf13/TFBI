// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
part of '../submit_claim_property_loss_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitClaimPropertyLossTypes _$SubmitClaimPropertyLossTypesFromJson(
        Map<String, dynamic> json) =>
    SubmitClaimPropertyLossTypes(
      lob: json['lob'] as String?,
      code: json['code'] as String?,
      name: $enumDecodeNullable(_$PropertyLossTypesEnumEnumMap, json['name'],
          unknownValue: PropertyLossTypesEnum.undefined),
      shortName: json['shortName'] as String?,
    );

Map<String, dynamic> _$SubmitClaimPropertyLossTypesToJson(
        SubmitClaimPropertyLossTypes instance) =>
    <String, dynamic>{
      'lob': instance.lob,
      'code': instance.code,
      'name': _$PropertyLossTypesEnumEnumMap[instance.name],
      'shortName': instance.shortName,
    };

const _$PropertyLossTypesEnumEnumMap = {
  PropertyLossTypesEnum.fire: 'Fire',
  PropertyLossTypesEnum.liab: 'Liability',
  PropertyLossTypesEnum.prop: 'Property',
  PropertyLossTypesEnum.storm: 'Storm',
  PropertyLossTypesEnum.undefined: 'undefined',
};
