// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'primary_insured.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrimaryInsured _$PrimaryInsuredFromJson(Map<String, dynamic> json) =>
    PrimaryInsured(
      emailAddress: json['EmailAddress'] as String?,
      phoneType: json['PhoneType'] as String?,
      licenseState: json['LicenseState'] as String?,
      licenseClass: json['LicenseClass'] as String?,
      name: json['Name'] == null
          ? null
          : SubmitClaimName.fromJson(json['Name'] as Map<String, dynamic>),
      insuredType: json['InsuredType'] as String?,
      gender: json['Gender'] as String?,
      maritalStatus: json['MaritalStatus'] as String?,
      dateOfBirth: json['DateOfBirth'] as String?,
      address: json['Address'] == null
          ? null
          : SubmitClaimAddress.fromJson(
              json['Address'] as Map<String, dynamic>),
      primaryInd: json['PrimaryInd'] as String?,
      phone: json['Phone'] as String?,
      licenseNumber: json['LicenseNumber'] as String?,
    );

Map<String, dynamic> _$PrimaryInsuredToJson(PrimaryInsured instance) =>
    <String, dynamic>{
      'EmailAddress': instance.emailAddress,
      'PhoneType': instance.phoneType,
      'LicenseState': instance.licenseState,
      'LicenseClass': instance.licenseClass,
      'Name': instance.name,
      'InsuredType': instance.insuredType,
      'Gender': instance.gender,
      'MaritalStatus': instance.maritalStatus,
      'DateOfBirth': instance.dateOfBirth,
      'Address': instance.address,
      'PrimaryInd': instance.primaryInd,
      'Phone': instance.phone,
      'LicenseNumber': instance.licenseNumber,
    };
