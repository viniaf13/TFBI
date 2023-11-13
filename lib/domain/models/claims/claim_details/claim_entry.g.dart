// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimEntry _$ClaimEntryFromJson(Map<String, dynamic> json) => ClaimEntry(
      string:
          (json['entry'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ClaimEntryToJson(ClaimEntry instance) =>
    <String, dynamic>{
      'entry': instance.string,
    };
