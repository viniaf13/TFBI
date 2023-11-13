// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';

part 'generated/submit_claim_damage_location.g.dart';

@JsonSerializable()
class DamageLocation {
  const DamageLocation({
    this.indicatorLocation,
    this.indicatorSelected,
  });

  factory DamageLocation.fromJson(Map<String, dynamic> json) =>
      _$DamageLocationFromJson(json);
  Map<String, dynamic> toJson() => _$DamageLocationToJson(this);

  @JsonKey(name: 'indicatorLocation')
  final int? indicatorLocation;
  @JsonKey(name: 'indicatorSelected')
  final bool? indicatorSelected;

  DamageLocation copyWith({
    int? indicatorLocation,
    bool? indicatorSelected,
  }) =>
      DamageLocation(
        indicatorLocation: indicatorLocation ?? this.indicatorLocation,
        indicatorSelected: indicatorSelected ?? this.indicatorSelected,
      );
}
