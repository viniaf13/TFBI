// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_payables.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimPayables _$ClaimPayablesFromJson(Map<String, dynamic> json) =>
    ClaimPayables(
      claimPayable: (json['claimPayable'] as List<dynamic>?)
          ?.map((e) => ClaimPayable.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClaimPayablesToJson(ClaimPayables instance) =>
    <String, dynamic>{
      'claimPayable': instance.claimPayable,
    };
