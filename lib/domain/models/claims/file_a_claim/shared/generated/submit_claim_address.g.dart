// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../submit_claim_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitClaimAddress _$SubmitClaimAddressFromJson(Map<String, dynamic> json) =>
    SubmitClaimAddress(
      addressLine1: json['AddressLine1'] as String?,
      addressLine2: json['AddressLine2'] as String?,
      city: json['City'] as String?,
      state: json['State'] as String?,
      zip: json['Zip'] as String?,
    );

Map<String, dynamic> _$SubmitClaimAddressToJson(SubmitClaimAddress instance) =>
    <String, dynamic>{
      'AddressLine1': instance.addressLine1,
      'AddressLine2': instance.addressLine2,
      'City': instance.city,
      'State': instance.state,
      'Zip': instance.zip,
    };
