// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../submit_claim_auto_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutoClaimInformation _$AutoClaimInformationFromJson(
        Map<String, dynamic> json) =>
    AutoClaimInformation(
      driver: json['driver'] == null
          ? null
          : AutoPrimaryInsured.fromJson(json['driver'] as Map<String, dynamic>),
      vehicle: json['vehicle'] == null
          ? null
          : SubmitClaimVehicle.fromJson(
              json['vehicle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AutoClaimInformationToJson(
        AutoClaimInformation instance) =>
    <String, dynamic>{
      'driver': instance.driver,
      'vehicle': instance.vehicle,
    };
