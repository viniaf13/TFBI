// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_indicator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimIndicator _$ClaimIndicatorFromJson(Map<String, dynamic> json) =>
    ClaimIndicator(
      recordId: json['recordId'] as String?,
      version: json['version'] as String?,
      updated: json['updated'] as String?,
      childUpdated: json['childUpdated'] as String?,
      dtoUtilsSynchronized: json['dtoUtilsSynchronized'] as String?,
      userIdCreated: json['userIdCreated'] as String?,
      createdDateTime: json['createdDateTime'] as String?,
      catastropheIndicator: json['catastropheIndicator'] as String?,
      claimReviewIndicator: json['claimReviewIndicator'] as String?,
      externalIndicator: json['externalIndicator'] as String?,
      largeLossIndicator: json['largeLossIndicator'] as String?,
      legalIndicator: json['legalIndicator'] as String?,
      privacyIndicator: json['privacyIndicator'] as String?,
      siuIndicator: json['siuIndicator'] as String?,
    );

Map<String, dynamic> _$ClaimIndicatorToJson(ClaimIndicator instance) =>
    <String, dynamic>{
      'recordId': instance.recordId,
      'version': instance.version,
      'updated': instance.updated,
      'childUpdated': instance.childUpdated,
      'dtoUtilsSynchronized': instance.dtoUtilsSynchronized,
      'userIdCreated': instance.userIdCreated,
      'createdDateTime': instance.createdDateTime,
      'catastropheIndicator': instance.catastropheIndicator,
      'claimReviewIndicator': instance.claimReviewIndicator,
      'externalIndicator': instance.externalIndicator,
      'largeLossIndicator': instance.largeLossIndicator,
      'legalIndicator': instance.legalIndicator,
      'privacyIndicator': instance.privacyIndicator,
      'siuIndicator': instance.siuIndicator,
    };
