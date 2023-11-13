// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';

import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/policy_details/deductibles.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/policy_details/limits.dart';

part 'coverages.g.dart';

@JsonSerializable()
class Coverages {
  Coverages({
    this.coverageCode,
    this.name,
    this.effectiveDate,
    this.expirationDate,
    this.limits,
    this.deductibles,
  });

  factory Coverages.fromJson(Map<String, dynamic> json) =>
      _$CoveragesFromJson(json);

  @JsonKey(name: 'CoverageCode')
  String? coverageCode;
  @JsonKey(name: 'Name')
  String? name;
  @JsonKey(name: 'EffectiveDate')
  String? effectiveDate;
  @JsonKey(name: 'ExpirationDate')
  String? expirationDate;
  @JsonKey(name: 'Limits')
  List<Limits>? limits;
  @JsonKey(name: 'Deductibles')
  List<Deductibles>? deductibles;
  Map<String, dynamic> toJson() => _$CoveragesToJson(this);
}
