// coverage:ignore-file
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';

part 'claim_indicator.g.dart';

@JsonSerializable()
class ClaimIndicator {
  ClaimIndicator({
    this.recordId,
    this.version,
    this.updated,
    this.childUpdated,
    this.dtoUtilsSynchronized,
    this.userIdCreated,
    this.createdDateTime,
    this.catastropheIndicator,
    this.claimReviewIndicator,
    this.externalIndicator,
    this.largeLossIndicator,
    this.legalIndicator,
    this.privacyIndicator,
    this.siuIndicator,
  });

  factory ClaimIndicator.fromJson(Map<String, dynamic> json) =>
      _$ClaimIndicatorFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimIndicatorToJson(this);

  @JsonKey(name: 'recordId')
  final String? recordId;
  @JsonKey(name: 'version')
  final String? version;
  @JsonKey(name: 'updated')
  final String? updated;
  @JsonKey(name: 'childUpdated')
  final String? childUpdated;
  @JsonKey(name: 'dtoUtilsSynchronized')
  final String? dtoUtilsSynchronized;
  @JsonKey(name: 'userIdCreated')
  final String? userIdCreated;
  @JsonKey(name: 'createdDateTime')
  final String? createdDateTime;
  @JsonKey(name: 'catastropheIndicator')
  final String? catastropheIndicator;
  @JsonKey(name: 'claimReviewIndicator')
  final String? claimReviewIndicator;
  @JsonKey(name: 'externalIndicator')
  final String? externalIndicator;
  @JsonKey(name: 'largeLossIndicator')
  final String? largeLossIndicator;
  @JsonKey(name: 'legalIndicator')
  final String? legalIndicator;
  @JsonKey(name: 'privacyIndicator')
  final String? privacyIndicator;
  @JsonKey(name: 'siuIndicator')
  final String? siuIndicator;

  ClaimIndicator copyWith({
    String? recordId,
    String? version,
    String? updated,
    String? childUpdated,
    String? dtoUtilsSynchronized,
    String? userIdCreated,
    String? createdDateTime,
    String? catastropheIndicator,
    String? claimReviewIndicator,
    String? externalIndicator,
    String? largeLossIndicator,
    String? legalIndicator,
    String? privacyIndicator,
    String? siuIndicator,
  }) =>
      ClaimIndicator(
        recordId: recordId ?? this.recordId,
        version: version ?? this.version,
        updated: updated ?? this.updated,
        childUpdated: childUpdated ?? this.childUpdated,
        dtoUtilsSynchronized: dtoUtilsSynchronized ?? this.dtoUtilsSynchronized,
        userIdCreated: userIdCreated ?? this.userIdCreated,
        createdDateTime: createdDateTime ?? this.createdDateTime,
        catastropheIndicator: catastropheIndicator ?? this.catastropheIndicator,
        claimReviewIndicator: claimReviewIndicator ?? this.claimReviewIndicator,
        externalIndicator: externalIndicator ?? this.externalIndicator,
        largeLossIndicator: largeLossIndicator ?? this.largeLossIndicator,
        legalIndicator: legalIndicator ?? this.legalIndicator,
        privacyIndicator: privacyIndicator ?? this.privacyIndicator,
        siuIndicator: siuIndicator ?? this.siuIndicator,
      );
}
