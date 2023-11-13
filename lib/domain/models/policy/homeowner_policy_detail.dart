// coverage:ignore-file

import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:txfb_insurance_flutter/domain/models/models.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/mortgagee.dart';

part 'homeowner_policy_detail.g.dart';

@JsonSerializable()
class HomeownerPolicyDetail extends PolicyDetail {
  HomeownerPolicyDetail(
    this.propertyLocation,
    this.propertyConstruction,
    this.policyForm,
    this.sections,
    this.insuredAddress, {
    required super.policyBilling,
    required super.policyType,
    required super.policySubType,
    required super.effectiveDate,
    required super.expirationDate,
    required super.policyDescription,
    required super.policyNumber,
    super.namedInsuredOne,
    super.namedInsuredTwo,
    super.writingCompanyName,
  });
  factory HomeownerPolicyDetail.fromJson(Map<String, dynamic> json) =>
      _$HomeownerPolicyDetailFromJson(json);

  @JsonKey(name: 'PropertyLocation')
  final String propertyLocation;
  @JsonKey(name: 'PropertyConstruction')
  final String propertyConstruction;
  @JsonKey(name: 'PolicyForm')
  final String policyForm;
  @JsonKey(name: 'Sections')
  final List<HomeownerSection> sections;
  @JsonKey(name: 'InsuredAddress')
  final Address insuredAddress;

  @override
  Map<String, dynamic> toJson() => _$HomeownerPolicyDetailToJson(this);
}

@JsonSerializable()
class HomeownerSection {
  HomeownerSection(
    this.name,
    this.coverages,
    this.deductibles,
    this.discounts,
    this.endorsements,
    this.mortgagees,
  );

  factory HomeownerSection.fromJson(Map<String, dynamic> json) =>
      _$HomeownerSectionFromJson(json);

  @JsonKey(name: 'Name')
  final String name;
  @JsonKey(name: 'Coverages')
  final List<HomeownerCoverage> coverages;
  @JsonKey(name: 'Deductibles')
  final List<HomeownerDeductible> deductibles;
  @JsonKey(name: 'Discounts')
  final List<HomeownerDiscount> discounts;
  @JsonKey(name: 'Endorsements')
  final List<HomeownerEndorsement> endorsements;
  @JsonKey(name: 'Mortgagees')
  final List<Mortgagee> mortgagees;

  Map<String, dynamic> toJson() => _$HomeownerSectionToJson(this);
}

@JsonSerializable()
class HomeownerCoverage {
  HomeownerCoverage(
    this.id,
    this.group,
    this.limit,
    this.name,
    this.objectSequenceNumber,
    this.objectType,
    this.premium,
  );

  factory HomeownerCoverage.fromJson(Map<String, dynamic> json) =>
      _$HomeownerCoverageFromJson(json);

  @JsonKey(name: 'Id')
  final String id;
  @JsonKey(name: 'Group')
  final String group;
  @JsonKey(name: 'Limit')
  final String limit;
  @JsonKey(name: 'Name')
  final String name;
  @JsonKey(name: 'ObjectSequenceNumber')
  final String objectSequenceNumber;
  @JsonKey(name: 'ObjectType')
  final String objectType;
  @JsonKey(name: 'Premium')
  final String premium;

  Map<String, dynamic> toJson() => _$HomeownerCoverageToJson(this);
}

@JsonSerializable()
class HomeownerDeductible {
  HomeownerDeductible(
    this.amount,
    this.id,
    this.name,
    this.objectSequenceNumber,
    this.objectType,
  );

  factory HomeownerDeductible.fromJson(Map<String, dynamic> json) =>
      _$HomeownerDeductibleFromJson(json);

  @JsonKey(name: 'Amount')
  final String amount;
  @JsonKey(name: 'Id')
  final String id;
  @JsonKey(name: 'Name')
  final String name;
  @JsonKey(name: 'ObjectSequenceNumber')
  final String objectSequenceNumber;
  @JsonKey(name: 'ObjectType')
  final String objectType;

  Map<String, dynamic> toJson() => _$HomeownerDeductibleToJson(this);
}

@JsonSerializable()
class HomeownerDiscount {
  HomeownerDiscount(
    this.name,
    this.value,
  );

  factory HomeownerDiscount.fromJson(Map<String, dynamic> json) =>
      _$HomeownerDiscountFromJson(json);

  @JsonKey(name: 'Name')
  final String name;
  @JsonKey(name: 'Value')
  final String value;

  Map<String, dynamic> toJson() => _$HomeownerDiscountToJson(this);
}

@JsonSerializable()
class HomeownerEndorsement {
  HomeownerEndorsement(
    this.id,
    this.limit,
    this.name,
    this.premium,
  );

  factory HomeownerEndorsement.fromJson(Map<String, dynamic> json) =>
      _$HomeownerEndorsementFromJson(json);

  @JsonKey(name: 'Id')
  final String id;
  @JsonKey(name: 'Limit')
  final String limit;
  @JsonKey(name: 'Name')
  final String name;
  @JsonKey(name: 'Premium')
  final String premium;

  Map<String, dynamic> toJson() => _$HomeownerEndorsementToJson(this);
}
