// coverage:ignore-file
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';

part 'claim_blocks_composite_dto.g.dart';

@JsonSerializable()
class ClaimBlocksCompositeDto {
  ClaimBlocksCompositeDto({
    this.updated,
    this.childUpdated,
    this.dtoUtilsSynchronized,
    this.claimBlocks,
    this.segmentationBlockInd,
  });

  factory ClaimBlocksCompositeDto.fromJson(Map<String, dynamic> json) =>
      _$ClaimBlocksCompositeDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ClaimBlocksCompositeDtoToJson(this);

  @JsonKey(name: 'updated')
  final String? updated;
  @JsonKey(name: 'childUpdated')
  final String? childUpdated;
  @JsonKey(name: 'dtoUtilsSynchronized')
  final String? dtoUtilsSynchronized;
  @JsonKey(name: 'claimBlocks')
  final String? claimBlocks;
  @JsonKey(name: 'segmentationBlockInd')
  final String? segmentationBlockInd;

  ClaimBlocksCompositeDto copyWith({
    String? updated,
    String? childUpdated,
    String? dtoUtilsSynchronized,
    String? claimBlocks,
    String? segmentationBlockInd,
  }) =>
      ClaimBlocksCompositeDto(
        updated: updated ?? this.updated,
        childUpdated: childUpdated ?? this.childUpdated,
        dtoUtilsSynchronized: dtoUtilsSynchronized ?? this.dtoUtilsSynchronized,
        claimBlocks: claimBlocks ?? this.claimBlocks,
        segmentationBlockInd: segmentationBlockInd ?? this.segmentationBlockInd,
      );
}
