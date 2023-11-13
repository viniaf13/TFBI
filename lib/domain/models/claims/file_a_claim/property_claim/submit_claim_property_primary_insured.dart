// coverage:ignore-file

import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_address.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_name.dart';

part 'generated/submit_claim_property_primary_insured.g.dart';

@JsonSerializable()
class PropertyPrimaryInsured {
  const PropertyPrimaryInsured({
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

  factory PropertyPrimaryInsured.fromJson(Map<String, dynamic> json) =>
      _$PropertyPrimaryInsuredFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyPrimaryInsuredToJson(this);

  final String? objectId;
  final String? emailAddress;
  final SubmitClaimName? name;
  final String? insuredType;
  final String? gender;
  final String? maritalStatus;
  final String? dateOfBirth;
  final SubmitClaimAddress? address;
  final String? primaryInd;
  final String? phone;
  final String? phoneType;
  final String? licenseNumber;
  final String? licenseState;
  final String? licenseClass;

  PropertyPrimaryInsured copyWith({
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
      PropertyPrimaryInsured(
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
