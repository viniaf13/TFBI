// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
part of '../submit_claim_damage_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DamageLocation _$DamageLocationFromJson(Map<String, dynamic> json) =>
    DamageLocation(
      indicatorLocation: json['indicatorLocation'] as int?,
      indicatorSelected: json['indicatorSelected'] as bool?,
    );

Map<String, dynamic> _$DamageLocationToJson(DamageLocation instance) =>
    <String, dynamic>{
      'indicatorLocation': instance.indicatorLocation,
      'indicatorSelected': instance.indicatorSelected,
    };
