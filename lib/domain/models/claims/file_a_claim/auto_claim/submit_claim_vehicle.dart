// coverage:ignore-file

import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_damage_location.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_owner_information.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_address.dart';

part 'generated/submit_claim_vehicle.g.dart';

@JsonSerializable()
class SubmitClaimVehicle {
  const SubmitClaimVehicle({
    this.objectId,
    this.licensePlate,
    this.licensePlateState,
    this.id,
    this.seqNum,
    this.address,
    this.year,
    this.make,
    this.model,
    this.vin,
    this.bodyStyle,
    this.isDriveable,
    this.currentLocation,
    this.externalIdValTxt,
    this.damageLocations,
    this.ownerInformation,
  });

  factory SubmitClaimVehicle.fromJson(Map<String, dynamic> json) =>
      _$SubmitClaimVehicleFromJson(json);
  Map<String, dynamic> toJson() => _$SubmitClaimVehicleToJson(this);

  @JsonKey(name: 'objectId')
  final String? objectId;
  @JsonKey(name: 'licensePlate')
  final String? licensePlate;
  @JsonKey(name: 'licensePlateState')
  final String? licensePlateState;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'seqNum')
  final String? seqNum;
  @JsonKey(name: 'address')
  final SubmitClaimAddress? address;
  @JsonKey(name: 'year')
  final String? year;
  @JsonKey(name: 'make')
  final String? make;
  @JsonKey(name: 'model')
  final String? model;
  @JsonKey(name: 'vin')
  final String? vin;
  @JsonKey(name: 'bodyStyle')
  final String? bodyStyle;
  @JsonKey(name: 'isDriveable')
  final String? isDriveable;
  @JsonKey(name: 'currentLocation')
  final String? currentLocation;
  @JsonKey(name: 'externalIdValTxt')
  final String? externalIdValTxt;
  @JsonKey(name: 'damageLocations')
  final List<DamageLocation>? damageLocations;
  @JsonKey(name: 'ownerInformation')
  final OwnerInformation? ownerInformation;

  SubmitClaimVehicle copyWith({
    String? objectId,
    String? licensePlate,
    String? licensePlateState,
    String? id,
    String? seqNum,
    SubmitClaimAddress? address,
    String? year,
    String? make,
    String? model,
    String? vin,
    String? bodyStyle,
    String? isDriveable,
    String? currentLocation,
    String? externalIdValTxt,
    List<DamageLocation>? damageLocations,
    OwnerInformation? ownerInformation,
  }) =>
      SubmitClaimVehicle(
        objectId: objectId ?? this.objectId,
        licensePlate: licensePlate ?? this.licensePlate,
        licensePlateState: licensePlateState ?? this.licensePlateState,
        id: id ?? this.id,
        seqNum: seqNum ?? this.seqNum,
        address: address ?? this.address,
        year: year ?? this.year,
        make: make ?? this.make,
        model: model ?? this.model,
        vin: vin ?? this.vin,
        bodyStyle: bodyStyle ?? this.bodyStyle,
        isDriveable: isDriveable ?? this.isDriveable,
        currentLocation: currentLocation ?? this.currentLocation,
        externalIdValTxt: externalIdValTxt ?? this.externalIdValTxt,
        damageLocations: damageLocations ?? this.damageLocations,
        ownerInformation: ownerInformation ?? this.ownerInformation,
      );
}
