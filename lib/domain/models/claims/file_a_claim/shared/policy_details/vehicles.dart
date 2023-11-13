// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_address.dart';

import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/policy_details/coverages.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/policy_details/endorsements.dart';

part 'vehicles.g.dart';

@JsonSerializable()
class Vehicles {
  Vehicles({
    this.licensePlate,
    this.seqNum,
    this.id,
    this.effectiveDate,
    this.expirationDate,
    this.address,
    this.endorsements,
    this.coverages,
    this.year,
    this.make,
    this.model,
    this.bodyStyle,
    this.vin,
    this.externalIdValTxt,
  });

  factory Vehicles.fromJson(Map<String, dynamic> json) =>
      _$VehiclesFromJson(json);

  @JsonKey(name: 'LicensePlate')
  String? licensePlate;
  @JsonKey(name: 'SeqNum')
  String? seqNum;
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'EffectiveDate')
  String? effectiveDate;
  @JsonKey(name: 'ExpirationDate')
  String? expirationDate;
  @JsonKey(name: 'Address')
  SubmitClaimAddress? address;
  @JsonKey(name: 'Endorsements')
  List<Endorsements>? endorsements;
  @JsonKey(name: 'Coverages')
  List<Coverages>? coverages;
  @JsonKey(name: 'Year')
  String? year;
  @JsonKey(name: 'Make')
  String? make;
  @JsonKey(name: 'Model')
  String? model;
  @JsonKey(name: 'BodyStyle')
  String? bodyStyle;
  @JsonKey(name: 'Vin')
  String? vin;
  @JsonKey(name: 'ExternalIdValTxt')
  String? externalIdValTxt;
  Map<String, dynamic> toJson() => _$VehiclesToJson(this);

  String yearMakeModel() => '$year $make $model';
}
