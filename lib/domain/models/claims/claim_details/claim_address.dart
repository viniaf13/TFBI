// coverage:ignore-file
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';

part 'claim_address.g.dart';

@JsonSerializable()
class ClaimAddress {
  ClaimAddress({
    this.recordId,
    this.version,
    this.updated,
    this.childUpdated,
    this.dtoUtilsSynchronized,
    this.userIdCreated,
    this.createdDateTime,
    this.delInd,
    this.countryCode,
    this.postalCodeExists,
    this.verifiedIndicator,
    this.overrideIndicator,
  });

  factory ClaimAddress.fromJson(Map<String, dynamic> json) =>
      _$ClaimAddressFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimAddressToJson(this);

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
  @JsonKey(name: 'delInd')
  final String? delInd;
  @JsonKey(name: 'countryCode')
  final String? countryCode;
  @JsonKey(name: 'postalCodeExists')
  final String? postalCodeExists;
  @JsonKey(name: 'verifiedIndicator')
  final String? verifiedIndicator;
  @JsonKey(name: 'overrideIndicator')
  final String? overrideIndicator;

  ClaimAddress copyWith({
    String? recordId,
    String? version,
    String? updated,
    String? childUpdated,
    String? dtoUtilsSynchronized,
    String? userIdCreated,
    String? createdDateTime,
    String? delInd,
    String? countryCode,
    String? postalCodeExists,
    String? verifiedIndicator,
    String? overrideIndicator,
  }) =>
      ClaimAddress(
        recordId: recordId ?? this.recordId,
        version: version ?? this.version,
        updated: updated ?? this.updated,
        childUpdated: childUpdated ?? this.childUpdated,
        dtoUtilsSynchronized: dtoUtilsSynchronized ?? this.dtoUtilsSynchronized,
        userIdCreated: userIdCreated ?? this.userIdCreated,
        createdDateTime: createdDateTime ?? this.createdDateTime,
        delInd: delInd ?? this.delInd,
        countryCode: countryCode ?? this.countryCode,
        postalCodeExists: postalCodeExists ?? this.postalCodeExists,
        verifiedIndicator: verifiedIndicator ?? this.verifiedIndicator,
        overrideIndicator: overrideIndicator ?? this.overrideIndicator,
      );
}
