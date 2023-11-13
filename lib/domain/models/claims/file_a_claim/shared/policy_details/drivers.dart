// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_address.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_name.dart';

part 'drivers.g.dart';

@JsonSerializable()
class Drivers {
  Drivers({
    this.emailAddress,
    this.phoneType,
    this.licenseState,
    this.licenseClass,
    this.name,
    this.insuredType,
    this.gender,
    this.maritalStatus,
    this.dateOfBirth,
    this.address,
    this.primaryInd,
    this.phone,
    this.licenseNumber,
  });

  factory Drivers.fromJson(Map<String, dynamic> json) =>
      _$DriversFromJson(json);

  @JsonKey(name: 'EmailAddress')
  String? emailAddress;
  @JsonKey(name: 'PhoneType')
  String? phoneType;
  @JsonKey(name: 'LicenseState')
  String? licenseState;
  @JsonKey(name: 'LicenseClass')
  String? licenseClass;
  @JsonKey(name: 'Name')
  SubmitClaimName? name;
  @JsonKey(name: 'InsuredType')
  String? insuredType;
  @JsonKey(name: 'Gender')
  String? gender;
  @JsonKey(name: 'MaritalStatus')
  String? maritalStatus;
  @JsonKey(name: 'DateOfBirth')
  String? dateOfBirth;
  @JsonKey(name: 'Address')
  SubmitClaimAddress? address;
  @JsonKey(name: 'PrimaryInd')
  String? primaryInd;
  @JsonKey(name: 'Phone')
  String? phone;
  @JsonKey(name: 'LicenseNumber')
  String? licenseNumber;
  Map<String, dynamic> toJson() => _$DriversToJson(this);
}
