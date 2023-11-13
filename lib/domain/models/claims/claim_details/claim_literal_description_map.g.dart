// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_literal_description_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimLiteralDescriptionMap _$ClaimLiteralDescriptionMapFromJson(
        Map<String, dynamic> json) =>
    ClaimLiteralDescriptionMap(
      claimEntry: (json['entry'] as List<dynamic>?)
          ?.map((e) => ClaimEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClaimLiteralDescriptionMapToJson(
        ClaimLiteralDescriptionMap instance) =>
    <String, dynamic>{
      'entry': instance.claimEntry,
    };
