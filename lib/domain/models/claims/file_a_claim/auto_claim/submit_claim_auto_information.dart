// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_auto_primary_insured.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle.dart';

part 'generated/submit_claim_auto_information.g.dart';

@JsonSerializable()
class AutoClaimInformation {
  const AutoClaimInformation({
    this.driver,
    this.vehicle,
  });

  factory AutoClaimInformation.fromJson(Map<String, dynamic> json) =>
      _$AutoClaimInformationFromJson(json);
  Map<String, dynamic> toJson() => _$AutoClaimInformationToJson(this);

  @JsonKey(name: 'driver')
  final AutoPrimaryInsured? driver;
  @JsonKey(name: 'vehicle')
  final SubmitClaimVehicle? vehicle;

  AutoClaimInformation copyWith({
    AutoPrimaryInsured? driver,
    SubmitClaimVehicle? vehicle,
  }) =>
      AutoClaimInformation(
        driver: driver ?? this.driver,
        vehicle: vehicle ?? this.vehicle,
      );
}
