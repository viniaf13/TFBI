// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';

part 'generated/submit_claim_vehicle_year.g.dart';

@JsonSerializable()
class SubmitClaimVehicleYear {
  const SubmitClaimVehicleYear({
    this.key,
    this.value,
  });

  factory SubmitClaimVehicleYear.fromJson(Map<String, dynamic> json) =>
      _$SubmitClaimVehicleYearFromJson(json);
  Map<String, dynamic> toJson() => _$SubmitClaimVehicleYearToJson(this);

  @JsonKey(name: 'Key')
  final String? key; // Use key for requesting vehicle models
  @JsonKey(name: 'Value')
  final String? value; // Use value for display

  SubmitClaimVehicleYear copyWith({
    String? key,
    String? value,
  }) =>
      SubmitClaimVehicleYear(
        key: key ?? this.key,
        value: value ?? this.value,
      );

  @override
  String toString() {
    return '$value';
  }
}
