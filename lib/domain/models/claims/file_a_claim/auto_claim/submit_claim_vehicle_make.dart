// coverage:ignore-file
import 'package:json_annotation/json_annotation.dart';

part 'generated/submit_claim_vehicle_make.g.dart';

@JsonSerializable()
class SubmitClaimVehicleMake {
  const SubmitClaimVehicleMake({
    this.key,
    this.value,
  });

  factory SubmitClaimVehicleMake.fromJson(Map<String, dynamic> json) =>
      _$SubmitClaimVehicleMakeFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitClaimVehicleMakeToJson(this);

  // Key and Value are the same; either can be used
  @JsonKey(name: 'Key')
  final String? key;
  @JsonKey(name: 'Value')
  final String? value;

  SubmitClaimVehicleMake copyWith({
    String? key,
    String? value,
  }) =>
      SubmitClaimVehicleMake(
        key: key ?? this.key,
        value: value ?? this.value,
      );
}
