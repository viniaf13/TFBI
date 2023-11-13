// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
part of '../submit_claim_auto_loss_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitClaimAutoLossTypes _$SubmitClaimAutoLossTypesFromJson(
        Map<String, dynamic> json) =>
    SubmitClaimAutoLossTypes(
      lob: json['lob'] as String?,
      code: json['code'] as String?,
      name: $enumDecodeNullable(_$AutoLossTypesEnumEnumMap, json['name'],
          unknownValue: AutoLossTypesEnum.undefined),
      shortName: json['shortName'] as String?,
    );

Map<String, dynamic> _$SubmitClaimAutoLossTypesToJson(
        SubmitClaimAutoLossTypes instance) =>
    <String, dynamic>{
      'lob': instance.lob,
      'code': instance.code,
      'name': _$AutoLossTypesEnumEnumMap[instance.name],
      'shortName': instance.shortName,
    };

const _$AutoLossTypesEnumEnumMap = {
  AutoLossTypesEnum.autoglass: 'Auto Glass',
  AutoLossTypesEnum.cainjr: 'Injury',
  AutoLossTypesEnum.caprop: 'Property',
  AutoLossTypesEnum.rentalveh: 'Rental Vehicle',
  AutoLossTypesEnum.pacompnot: 'Comp Causes Not Specified',
  AutoLossTypesEnum.enstire: 'Ensuing Damage From Tire Tread Blow-out',
  AutoLossTypesEnum.pafire: 'Fire',
  AutoLossTypesEnum.paflood: 'Flood, Rising Water or Other Water Damage',
  AutoLossTypesEnum.pagravel: 'Flying Gravel or Falling Missiles',
  AutoLossTypesEnum.paglassrepair: 'Glass Repair',
  AutoLossTypesEnum.paglassreplace: 'Glass Replace',
  AutoLossTypesEnum.pahail: 'Hail or Ensuing Storm',
  AutoLossTypesEnum.pahitrun: 'Hit and Run',
  AutoLossTypesEnum.pahitanimal: 'Hit Domestic/Farm Animal or Fowl',
  AutoLossTypesEnum.pawild: 'Hit Wild Animal',
  AutoLossTypesEnum.palegpark:
      'Legally Parked, Stopped, Standing (Driver in Vehicle)',
  AutoLossTypesEnum.pamulti: 'Multi-Vehicle Collision',
  AutoLossTypesEnum.pamultiinj: 'Multi-Vehicle Collision with Injuries',
  AutoLossTypesEnum.parear: 'Rear-end Collision',
  AutoLossTypesEnum.rent: 'Rental Vehicle Damage',
  AutoLossTypesEnum.paroad: 'Roadside Assistance (Towing)',
  AutoLossTypesEnum.pasingle: 'Single Car Collision',
  AutoLossTypesEnum.pasingleinj: 'Single Car Collision with Injuries',
  AutoLossTypesEnum.patheft: 'Theft',
  AutoLossTypesEnum.pavand: 'Vandalism/Partial Theft of Vehicle',
  AutoLossTypesEnum.undefined: 'undefined',
};
