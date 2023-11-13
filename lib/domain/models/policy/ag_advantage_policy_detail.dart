// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';
import 'package:txfb_insurance_flutter/domain/models/models.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/mortgagee.dart';

part 'ag_advantage_policy_detail.g.dart';

/// Note: This is currently identical to HomeownerPolicyDetail.
/// But this is a subset of total fields.
@JsonSerializable()
class AgAdvantagePolicyDetail extends PolicyDetail {
  AgAdvantagePolicyDetail(
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
  factory AgAdvantagePolicyDetail.fromJson(Map<String, dynamic> json) =>
      _$AgAdvantagePolicyDetailFromJson(json);

  @JsonKey(name: 'PropertyLocation')
  final String propertyLocation;
  @JsonKey(name: 'PropertyConstruction')
  final String propertyConstruction;
  @JsonKey(name: 'PolicyForm')
  final String policyForm;
  @JsonKey(name: 'Sections')
  final List<AgAdvantageSection> sections;
  @JsonKey(name: 'InsuredAddress')
  final Address insuredAddress;

  @override
  Map<String, dynamic> toJson() => _$AgAdvantagePolicyDetailToJson(this);
}

@JsonSerializable()
class AgAdvantageSection {
  AgAdvantageSection(
    this.coverages,
    this.deductibles,
    this.discounts,
    this.endorsements,
    this.mortgagees,
    this.name,
  );

  factory AgAdvantageSection.fromJson(Map<String, dynamic> json) =>
      _$AgAdvantageSectionFromJson(json);

  @JsonKey(name: 'Coverages')
  final List<AgAdvantageCoverage> coverages;
  @JsonKey(name: 'Deductibles')
  final List<AgAdvantageDeductible> deductibles;
  @JsonKey(name: 'Discounts')
  final List<AgAdvantageDiscount> discounts;
  @JsonKey(name: 'Endorsements')
  final List<AgAdvantageEndorsement> endorsements;
  @JsonKey(name: 'Mortgagees')
  final List<Mortgagee> mortgagees;
  @JsonKey(name: 'Name')
  final String name;

  Map<String, dynamic> toJson() => _$AgAdvantageSectionToJson(this);
}

@JsonSerializable()
class AgAdvantageCoverage {
  AgAdvantageCoverage(
    this.group,
    this.coverageDetail,
    this.id,
    this.limit,
    this.name,
    this.objectSequenceNumber,
    this.objectType,
    this.premium,
  );

  factory AgAdvantageCoverage.fromJson(Map<String, dynamic> json) =>
      _$AgAdvantageCoverageFromJson(json);

  @JsonKey(name: 'CoverageDetail')
  final String? coverageDetail;
  @JsonKey(name: 'Group')
  final String? group;
  @JsonKey(name: 'Id')
  final String id;
  @JsonKey(name: 'Limit')
  final String limit;
  @JsonKey(name: 'Name')
  final String name;
  @JsonKey(name: 'ObjectSequenceNumber')
  final String objectSequenceNumber;
  @JsonKey(name: 'ObjectType')
  final String objectType;
  @JsonKey(name: 'Premium')
  final String? premium;

  Map<String, dynamic> toJson() => _$AgAdvantageCoverageToJson(this);

  String get coverageLabel => group!.isNotEmpty ? '$group. $name' : name;
}

@JsonSerializable()
class AgAdvantageDeductible {
  AgAdvantageDeductible(
    this.id,
    this.amount,
    this.name,
    this.objectSequenceNumber,
    this.objectType,
  );

  factory AgAdvantageDeductible.fromJson(Map<String, dynamic> json) =>
      _$AgAdvantageDeductibleFromJson(json);

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

  Map<String, dynamic> toJson() => _$AgAdvantageDeductibleToJson(this);
}

@JsonSerializable()
class AgAdvantageDiscount {
  AgAdvantageDiscount(this.name, this.value);

  factory AgAdvantageDiscount.fromJson(Map<String, dynamic> json) =>
      _$AgAdvantageDiscountFromJson(json);

  @JsonKey(name: 'Name')
  final String name;
  @JsonKey(name: 'Value')
  final String value;

  Map<String, dynamic> toJson() => _$AgAdvantageDiscountToJson(this);
}

@JsonSerializable()
class AgAdvantageEndorsement {
  AgAdvantageEndorsement(
    this.id,
    this.limit,
    this.name,
    this.premium,
  );

  factory AgAdvantageEndorsement.fromJson(Map<String, dynamic> json) =>
      _$AgAdvantageEndorsementFromJson(json);

  @JsonKey(name: 'Id')
  final String id;
  @JsonKey(name: 'Limit')
  final String limit;
  @JsonKey(name: 'Name')
  final String name;
  @JsonKey(name: 'Premium')
  final String? premium;

  Map<String, dynamic> toJson() => _$AgAdvantageEndorsementToJson(this);
}
