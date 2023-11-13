// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_blocks_composite_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimBlocksCompositeDto _$ClaimBlocksCompositeDtoFromJson(
        Map<String, dynamic> json) =>
    ClaimBlocksCompositeDto(
      updated: json['updated'] as String?,
      childUpdated: json['childUpdated'] as String?,
      dtoUtilsSynchronized: json['dtoUtilsSynchronized'] as String?,
      claimBlocks: json['claimBlocks'] as String?,
      segmentationBlockInd: json['segmentationBlockInd'] as String?,
    );

Map<String, dynamic> _$ClaimBlocksCompositeDtoToJson(
        ClaimBlocksCompositeDto instance) =>
    <String, dynamic>{
      'updated': instance.updated,
      'childUpdated': instance.childUpdated,
      'dtoUtilsSynchronized': instance.dtoUtilsSynchronized,
      'claimBlocks': instance.claimBlocks,
      'segmentationBlockInd': instance.segmentationBlockInd,
    };
