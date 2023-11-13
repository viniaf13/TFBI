// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';

part 'generated/submit_claim_county.g.dart';

@JsonSerializable()
class SubmitClaimCounty {
  const SubmitClaimCounty({
    this.countyCode,
    this.countyName,
  });

  factory SubmitClaimCounty.fromJson(Map<String, dynamic> json) =>
      _$SubmitClaimCountyFromJson(json);
  Map<String, dynamic> toJson() => _$SubmitClaimCountyToJson(this);

  @JsonKey(name: 'CountyCode')
  final String? countyCode;
  @JsonKey(name: 'CountyName')
  final String? countyName;

  SubmitClaimCounty copyWith({
    String? countyCode,
    String? countyName,
  }) =>
      SubmitClaimCounty(
        countyCode: countyCode ?? this.countyCode,
        countyName: countyName ?? this.countyName,
      );

  @override
  String toString() {
    return '$countyName($countyCode)';
  }
}
