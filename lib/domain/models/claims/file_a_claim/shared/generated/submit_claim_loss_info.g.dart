// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../submit_claim_loss_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LossInformation _$LossInformationFromJson(Map<String, dynamic> json) =>
    LossInformation(
      dateOfLoss: json['dateOfLoss'] as String?,
      timeOfLoss: json['timeOfLoss'] as String?,
      typeOfLoss: json['typeOfLoss'] as String?,
      lossDescription: json['lossDescription'] as String?,
      location: json['location'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      county: json['county'] as String?,
      zip: json['zip'] as String?,
      policeDepartment: json['policeDepartment'] as String?,
      policeCaseNumber: json['policeCaseNumber'] as String?,
    );

Map<String, dynamic> _$LossInformationToJson(LossInformation instance) =>
    <String, dynamic>{
      'dateOfLoss': instance.dateOfLoss,
      'timeOfLoss': instance.timeOfLoss,
      'typeOfLoss': instance.typeOfLoss,
      'lossDescription': instance.lossDescription,
      'location': instance.location,
      'city': instance.city,
      'state': instance.state,
      'county': instance.county,
      'zip': instance.zip,
      'policeDepartment': instance.policeDepartment,
      'policeCaseNumber': instance.policeCaseNumber,
    };
