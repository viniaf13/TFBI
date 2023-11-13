// coverage:ignore-file
import 'package:json_annotation/json_annotation.dart';

part 'generated/submit_claim_vehicle_model.g.dart';

@JsonSerializable()
class VehicleModelRequest {
  const VehicleModelRequest({
    this.year,
    this.make,
  });

  factory VehicleModelRequest.fromJson(Map<String, dynamic> json) =>
      _$VehicleModelRequestFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleModelRequestToJson(this);

  final String? year;
  final String? make;

  VehicleModelRequest copyWith({
    String? year,
    String? make,
  }) =>
      VehicleModelRequest(
        year: year ?? this.year,
        make: make ?? this.make,
      );
}

@JsonSerializable()
class VehicleModelResponse {
  VehicleModelResponse({
    this.key,
    this.value,
  });

  factory VehicleModelResponse.fromJson(Map<String, dynamic> json) =>
      _$VehicleModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleModelResponseToJson(this);

  @JsonKey(name: 'Key')
  final String? key;
  @JsonKey(name: 'Value')
  final String? value;

  VehicleModelResponse copyWith({
    String? key,
    String? value,
  }) =>
      VehicleModelResponse(
        key: key ?? this.key,
        value: value ?? this.value,
      );
}
