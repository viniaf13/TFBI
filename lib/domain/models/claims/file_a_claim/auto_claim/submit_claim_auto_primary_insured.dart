// coverage:ignore-file

import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_address.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_name.dart';

part 'generated/submit_claim_auto_primary_insured.g.dart';

@JsonSerializable()
class AutoPrimaryInsured {
  const AutoPrimaryInsured({
    this.injuryInd,
    this.injuryDescription,
    this.objectId,
    this.emailAddress,
    this.name,
    this.insuredType,
    this.gender,
    this.maritalStatus,
    this.dateOfBirth,
    this.address,
    this.primaryInd,
    this.phone,
    this.phoneType,
    this.licenseNumber,
    this.licenseState,
    this.licenseClass,
  });

  factory AutoPrimaryInsured.fromJson(Map<String, dynamic> json) =>
      _$AutoPrimaryInsuredFromJson(json);
  Map<String, dynamic> toJson() => _$AutoPrimaryInsuredToJson(this);

  @JsonKey(name: 'injuryInd')
  final String? injuryInd;
  @JsonKey(name: 'injuryDescription')
  final String? injuryDescription;
  @JsonKey(name: 'objectId')
  final String? objectId;
  @JsonKey(name: 'emailAddress')
  final String? emailAddress;
  @JsonKey(name: 'name')
  final SubmitClaimName? name;
  @JsonKey(name: 'insuredType')
  final String? insuredType;
  @JsonKey(name: 'gender')
  final String? gender;
  @JsonKey(name: 'maritalStatus')
  final String? maritalStatus;
  @JsonKey(name: 'dateOfBirth')
  final String? dateOfBirth;
  @JsonKey(name: 'address')
  final SubmitClaimAddress? address;
  @JsonKey(name: 'primaryInd')
  final String? primaryInd;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'phoneType')
  final String? phoneType;
  @JsonKey(name: 'licenseNumber')
  final String? licenseNumber;
  @JsonKey(name: 'licenseState')
  final String? licenseState;
  @JsonKey(name: 'licenseClass')
  final String? licenseClass;

  AutoPrimaryInsured copyWith({
    String? injuryInd,
    String? injuryDescription,
    String? objectId,
    String? emailAddress,
    SubmitClaimName? name,
    String? insuredType,
    String? gender,
    String? maritalStatus,
    String? dateOfBirth,
    SubmitClaimAddress? address,
    String? primaryInd,
    String? phone,
    String? phoneType,
    String? licenseNumber,
    String? licenseState,
    String? licenseClass,
  }) =>
      AutoPrimaryInsured(
        injuryInd: injuryInd ?? this.injuryInd,
        injuryDescription: injuryDescription ?? this.injuryDescription,
        objectId: objectId ?? this.objectId,
        emailAddress: emailAddress ?? this.emailAddress,
        name: name ?? this.name,
        insuredType: insuredType ?? this.insuredType,
        gender: gender ?? this.gender,
        maritalStatus: maritalStatus ?? this.maritalStatus,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        address: address ?? this.address,
        primaryInd: primaryInd ?? this.primaryInd,
        phone: phone ?? this.phone,
        phoneType: phoneType ?? this.phoneType,
        licenseNumber: licenseNumber ?? this.licenseNumber,
        licenseState: licenseState ?? this.licenseState,
        licenseClass: licenseClass ?? this.licenseClass,
      );
}
