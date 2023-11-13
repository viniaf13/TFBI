// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
part of '../submit_claim_auto_primary_insured.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutoPrimaryInsured _$AutoPrimaryInsuredFromJson(Map<String, dynamic> json) =>
    AutoPrimaryInsured(
      injuryInd: json['injuryInd'] as String?,
      injuryDescription: json['injuryDescription'] as String?,
      objectId: json['objectId'] as String?,
      emailAddress: json['emailAddress'] as String?,
      name: json['name'] == null
          ? null
          : SubmitClaimName.fromJson(json['name'] as Map<String, dynamic>),
      insuredType: json['insuredType'] as String?,
      gender: json['gender'] as String?,
      maritalStatus: json['maritalStatus'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      address: json['address'] == null
          ? null
          : SubmitClaimAddress.fromJson(
              json['address'] as Map<String, dynamic>),
      primaryInd: json['primaryInd'] as String?,
      phone: json['phone'] as String?,
      phoneType: json['phoneType'] as String?,
      licenseNumber: json['licenseNumber'] as String?,
      licenseState: json['licenseState'] as String?,
      licenseClass: json['licenseClass'] as String?,
    );

Map<String, dynamic> _$AutoPrimaryInsuredToJson(AutoPrimaryInsured instance) =>
    <String, dynamic>{
      'injuryInd': instance.injuryInd,
      'injuryDescription': instance.injuryDescription,
      'objectId': instance.objectId,
      'emailAddress': instance.emailAddress,
      'name': instance.name,
      'insuredType': instance.insuredType,
      'gender': instance.gender,
      'maritalStatus': instance.maritalStatus,
      'dateOfBirth': instance.dateOfBirth,
      'address': instance.address,
      'primaryInd': instance.primaryInd,
      'phone': instance.phone,
      'phoneType': instance.phoneType,
      'licenseNumber': instance.licenseNumber,
      'licenseState': instance.licenseState,
      'licenseClass': instance.licenseClass,
    };
