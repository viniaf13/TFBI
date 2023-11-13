// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimAddress _$ClaimAddressFromJson(Map<String, dynamic> json) => ClaimAddress(
      recordId: json['recordId'] as String?,
      version: json['version'] as String?,
      updated: json['updated'] as String?,
      childUpdated: json['childUpdated'] as String?,
      dtoUtilsSynchronized: json['dtoUtilsSynchronized'] as String?,
      userIdCreated: json['userIdCreated'] as String?,
      createdDateTime: json['createdDateTime'] as String?,
      delInd: json['delInd'] as String?,
      countryCode: json['countryCode'] as String?,
      postalCodeExists: json['postalCodeExists'] as String?,
      verifiedIndicator: json['verifiedIndicator'] as String?,
      overrideIndicator: json['overrideIndicator'] as String?,
    );

Map<String, dynamic> _$ClaimAddressToJson(ClaimAddress instance) =>
    <String, dynamic>{
      'recordId': instance.recordId,
      'version': instance.version,
      'updated': instance.updated,
      'childUpdated': instance.childUpdated,
      'dtoUtilsSynchronized': instance.dtoUtilsSynchronized,
      'userIdCreated': instance.userIdCreated,
      'createdDateTime': instance.createdDateTime,
      'delInd': instance.delInd,
      'countryCode': instance.countryCode,
      'postalCodeExists': instance.postalCodeExists,
      'verifiedIndicator': instance.verifiedIndicator,
      'overrideIndicator': instance.overrideIndicator,
    };
