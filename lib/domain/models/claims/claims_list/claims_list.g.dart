// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claims_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimsList _$ClaimsListFromJson(Map<String, dynamic> json) => ClaimsList(
      claims: (json['claims'] as List<dynamic>?)
          ?.map((e) => Claim.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClaimsListToJson(ClaimsList instance) =>
    <String, dynamic>{
      'claims': instance.claims,
    };
