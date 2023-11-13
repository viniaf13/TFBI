// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coverages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coverages _$CoveragesFromJson(Map<String, dynamic> json) => Coverages(
      coverageCode: json['CoverageCode'] as String?,
      name: json['Name'] as String?,
      effectiveDate: json['EffectiveDate'] as String?,
      expirationDate: json['ExpirationDate'] as String?,
      limits: (json['Limits'] as List<dynamic>?)
          ?.map((e) => Limits.fromJson(e as Map<String, dynamic>))
          .toList(),
      deductibles: (json['Deductibles'] as List<dynamic>?)
          ?.map((e) => Deductibles.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CoveragesToJson(Coverages instance) => <String, dynamic>{
      'CoverageCode': instance.coverageCode,
      'Name': instance.name,
      'EffectiveDate': instance.effectiveDate,
      'ExpirationDate': instance.expirationDate,
      'Limits': instance.limits,
      'Deductibles': instance.deductibles,
    };
