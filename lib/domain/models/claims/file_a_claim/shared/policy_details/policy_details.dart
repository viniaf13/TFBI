// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';

import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/policy_details/drivers.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/policy_details/primary_insured.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/policy_details/vehicles.dart';

part 'policy_details.g.dart';

@JsonSerializable()
class PolicyDetails {
  PolicyDetails({
    this.drivers,
    this.vehicles,
    this.claimDestination,
    this.claimType,
    this.dateOfLoss,
    this.effectiveDate,
    this.expirationDate,
    this.memberNumber,
    this.policyNumber,
    this.policySymbol,
    this.policyTypeCrm,
    this.policyType,
    this.policySubType,
    this.originalEffectiveDate,
    this.externalIdValTxt,
    this.companyName,
    this.corporationName,
    this.primaryInsured,
  });

  factory PolicyDetails.fromJson(Map<String, dynamic> json) =>
      _$PolicyDetailsFromJson(json);

  @JsonKey(name: 'Drivers')
  List<Drivers>? drivers;
  @JsonKey(name: 'Vehicles')
  List<Vehicles>? vehicles;
  @JsonKey(name: 'ClaimDestination')
  int? claimDestination;
  @JsonKey(name: 'ClaimType')
  int? claimType;
  @JsonKey(name: 'DateOfLoss')
  String? dateOfLoss;
  @JsonKey(name: 'EffectiveDate')
  String? effectiveDate;
  @JsonKey(name: 'ExpirationDate')
  String? expirationDate;
  @JsonKey(name: 'MemberNumber')
  String? memberNumber;
  @JsonKey(name: 'PolicyNumber')
  String? policyNumber;
  @JsonKey(name: 'PolicySymbol')
  String? policySymbol;
  @JsonKey(name: 'PolicyTypeCrm')
  String? policyTypeCrm;
  @JsonKey(name: 'PolicyType')
  String? policyType;
  @JsonKey(name: 'PolicySubType')
  String? policySubType;
  @JsonKey(name: 'OriginalEffectiveDate')
  String? originalEffectiveDate;
  @JsonKey(name: 'ExternalIdValTxt')
  String? externalIdValTxt;
  @JsonKey(name: 'CompanyName')
  String? companyName;
  @JsonKey(name: 'CorporationName')
  String? corporationName;
  @JsonKey(name: 'PrimaryInsured')
  PrimaryInsured? primaryInsured;
  Map<String, dynamic> toJson() => _$PolicyDetailsToJson(this);
}
