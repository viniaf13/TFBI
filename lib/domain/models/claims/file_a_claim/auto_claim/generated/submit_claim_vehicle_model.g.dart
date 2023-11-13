// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../submit_claim_vehicle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleModelRequest _$VehicleModelRequestFromJson(Map<String, dynamic> json) =>
    VehicleModelRequest(
      year: json['year'] as String?,
      make: json['make'] as String?,
    );

Map<String, dynamic> _$VehicleModelRequestToJson(
        VehicleModelRequest instance) =>
    <String, dynamic>{
      'year': instance.year,
      'make': instance.make,
    };

VehicleModelResponse _$VehicleModelResponseFromJson(
        Map<String, dynamic> json) =>
    VehicleModelResponse(
      key: json['Key'] as String?,
      value: json['Value'] as String?,
    );

Map<String, dynamic> _$VehicleModelResponseToJson(
        VehicleModelResponse instance) =>
    <String, dynamic>{
      'Key': instance.key,
      'Value': instance.value,
    };
