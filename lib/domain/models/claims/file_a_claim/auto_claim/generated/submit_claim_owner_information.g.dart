// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
part of '../submit_claim_owner_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerInformation _$OwnerInformationFromJson(Map<String, dynamic> json) =>
    OwnerInformation(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      objectId: json['objectId'] as String?,
    );

Map<String, dynamic> _$OwnerInformationToJson(OwnerInformation instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'objectId': instance.objectId,
    };
