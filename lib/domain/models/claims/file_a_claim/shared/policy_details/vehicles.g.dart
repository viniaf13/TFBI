// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicles _$VehiclesFromJson(Map<String, dynamic> json) => Vehicles(
      licensePlate: json['LicensePlate'] as String?,
      seqNum: json['SeqNum'] as String?,
      id: json['Id'] as String?,
      effectiveDate: json['EffectiveDate'] as String?,
      expirationDate: json['ExpirationDate'] as String?,
      address: json['Address'] == null
          ? null
          : SubmitClaimAddress.fromJson(
              json['Address'] as Map<String, dynamic>),
      endorsements: (json['Endorsements'] as List<dynamic>?)
          ?.map((e) => Endorsements.fromJson(e as Map<String, dynamic>))
          .toList(),
      coverages: (json['Coverages'] as List<dynamic>?)
          ?.map((e) => Coverages.fromJson(e as Map<String, dynamic>))
          .toList(),
      year: json['Year'] as String?,
      make: json['Make'] as String?,
      model: json['Model'] as String?,
      bodyStyle: json['BodyStyle'] as String?,
      vin: json['Vin'] as String?,
      externalIdValTxt: json['ExternalIdValTxt'] as String?,
    );

Map<String, dynamic> _$VehiclesToJson(Vehicles instance) => <String, dynamic>{
      'LicensePlate': instance.licensePlate,
      'SeqNum': instance.seqNum,
      'Id': instance.id,
      'EffectiveDate': instance.effectiveDate,
      'ExpirationDate': instance.expirationDate,
      'Address': instance.address,
      'Endorsements': instance.endorsements,
      'Coverages': instance.coverages,
      'Year': instance.year,
      'Make': instance.make,
      'Model': instance.model,
      'BodyStyle': instance.bodyStyle,
      'Vin': instance.vin,
      'ExternalIdValTxt': instance.externalIdValTxt,
    };
