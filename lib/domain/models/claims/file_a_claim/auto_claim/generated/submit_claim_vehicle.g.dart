// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
part of '../submit_claim_vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitClaimVehicle _$SubmitClaimVehicleFromJson(Map<String, dynamic> json) =>
    SubmitClaimVehicle(
      objectId: json['objectId'] as String?,
      licensePlate: json['licensePlate'] as String?,
      licensePlateState: json['licensePlateState'] as String?,
      id: json['id'] as String?,
      seqNum: json['seqNum'] as String?,
      address: json['address'] == null
          ? null
          : SubmitClaimAddress.fromJson(
              json['address'] as Map<String, dynamic>),
      year: json['year'] as String?,
      make: json['make'] as String?,
      model: json['model'] as String?,
      vin: json['vin'] as String?,
      bodyStyle: json['bodyStyle'] as String?,
      isDriveable: json['isDriveable'] as String?,
      currentLocation: json['currentLocation'] as String?,
      externalIdValTxt: json['externalIdValTxt'] as String?,
      damageLocations: (json['damageLocations'] as List<dynamic>?)
          ?.map((e) => DamageLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
      ownerInformation: json['ownerInformation'] == null
          ? null
          : OwnerInformation.fromJson(
              json['ownerInformation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubmitClaimVehicleToJson(SubmitClaimVehicle instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'licensePlate': instance.licensePlate,
      'licensePlateState': instance.licensePlateState,
      'id': instance.id,
      'seqNum': instance.seqNum,
      'address': instance.address,
      'year': instance.year,
      'make': instance.make,
      'model': instance.model,
      'vin': instance.vin,
      'bodyStyle': instance.bodyStyle,
      'isDriveable': instance.isDriveable,
      'currentLocation': instance.currentLocation,
      'externalIdValTxt': instance.externalIdValTxt,
      'damageLocations': instance.damageLocations,
      'ownerInformation': instance.ownerInformation,
    };
