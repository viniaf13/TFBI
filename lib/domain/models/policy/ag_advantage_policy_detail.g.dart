// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ag_advantage_policy_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgAdvantagePolicyDetail _$AgAdvantagePolicyDetailFromJson(
        Map<String, dynamic> json) =>
    AgAdvantagePolicyDetail(
      json['PropertyLocation'] as String,
      json['PropertyConstruction'] as String,
      json['PolicyForm'] as String,
      (json['Sections'] as List<dynamic>)
          .map((e) => AgAdvantageSection.fromJson(e as Map<String, dynamic>))
          .toList(),
      Address.fromJson(json['InsuredAddress'] as Map<String, dynamic>),
      policyBilling:
          PolicyBilling.fromJson(json['PolicyBilling'] as Map<String, dynamic>),
      policyType: json['PolicyType'] as String,
      policySubType: json['PolicySubType'] as String,
      effectiveDate: json['EffectiveDate'] as String,
      expirationDate: json['ExpirationDate'] as String,
      policyDescription: json['PolicyDescription'] as String,
      policyNumber: json['PolicyNumber'] as String,
      namedInsuredOne: json['NamedInsuredOne'] as String?,
      namedInsuredTwo: json['NamedInsuredTwo'] as String?,
      writingCompanyName: json['WritingCompanyName'] as String?,
    );

Map<String, dynamic> _$AgAdvantagePolicyDetailToJson(
        AgAdvantagePolicyDetail instance) =>
    <String, dynamic>{
      'PolicyNumber': instance.policyNumber,
      'PolicyType': instance.policyType,
      'PolicySubType': instance.policySubType,
      'PolicyDescription': instance.policyDescription,
      'EffectiveDate': instance.effectiveDate,
      'ExpirationDate': instance.expirationDate,
      'NamedInsuredOne': instance.namedInsuredOne,
      'NamedInsuredTwo': instance.namedInsuredTwo,
      'WritingCompanyName': instance.writingCompanyName,
      'PolicyBilling': instance.policyBilling,
      'PropertyLocation': instance.propertyLocation,
      'PropertyConstruction': instance.propertyConstruction,
      'PolicyForm': instance.policyForm,
      'Sections': instance.sections,
      'InsuredAddress': instance.insuredAddress,
    };

AgAdvantageSection _$AgAdvantageSectionFromJson(Map<String, dynamic> json) =>
    AgAdvantageSection(
      (json['Coverages'] as List<dynamic>)
          .map((e) => AgAdvantageCoverage.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['Deductibles'] as List<dynamic>)
          .map((e) => AgAdvantageDeductible.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['Discounts'] as List<dynamic>)
          .map((e) => AgAdvantageDiscount.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['Endorsements'] as List<dynamic>)
          .map(
              (e) => AgAdvantageEndorsement.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['Mortgagees'] as List<dynamic>)
          .map((e) => Mortgagee.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['Name'] as String,
    );

Map<String, dynamic> _$AgAdvantageSectionToJson(AgAdvantageSection instance) =>
    <String, dynamic>{
      'Coverages': instance.coverages,
      'Deductibles': instance.deductibles,
      'Discounts': instance.discounts,
      'Endorsements': instance.endorsements,
      'Mortgagees': instance.mortgagees,
      'Name': instance.name,
    };

AgAdvantageCoverage _$AgAdvantageCoverageFromJson(Map<String, dynamic> json) =>
    AgAdvantageCoverage(
      json['Group'] as String?,
      json['CoverageDetail'] as String?,
      json['Id'] as String,
      json['Limit'] as String,
      json['Name'] as String,
      json['ObjectSequenceNumber'] as String,
      json['ObjectType'] as String,
      json['Premium'] as String?,
    );

Map<String, dynamic> _$AgAdvantageCoverageToJson(
        AgAdvantageCoverage instance) =>
    <String, dynamic>{
      'CoverageDetail': instance.coverageDetail,
      'Group': instance.group,
      'Id': instance.id,
      'Limit': instance.limit,
      'Name': instance.name,
      'ObjectSequenceNumber': instance.objectSequenceNumber,
      'ObjectType': instance.objectType,
      'Premium': instance.premium,
    };

AgAdvantageDeductible _$AgAdvantageDeductibleFromJson(
        Map<String, dynamic> json) =>
    AgAdvantageDeductible(
      json['Id'] as String,
      json['Amount'] as String,
      json['Name'] as String,
      json['ObjectSequenceNumber'] as String,
      json['ObjectType'] as String,
    );

Map<String, dynamic> _$AgAdvantageDeductibleToJson(
        AgAdvantageDeductible instance) =>
    <String, dynamic>{
      'Amount': instance.amount,
      'Id': instance.id,
      'Name': instance.name,
      'ObjectSequenceNumber': instance.objectSequenceNumber,
      'ObjectType': instance.objectType,
    };

AgAdvantageDiscount _$AgAdvantageDiscountFromJson(Map<String, dynamic> json) =>
    AgAdvantageDiscount(
      json['Name'] as String,
      json['Value'] as String,
    );

Map<String, dynamic> _$AgAdvantageDiscountToJson(
        AgAdvantageDiscount instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Value': instance.value,
    };

AgAdvantageEndorsement _$AgAdvantageEndorsementFromJson(
        Map<String, dynamic> json) =>
    AgAdvantageEndorsement(
      json['Id'] as String,
      json['Limit'] as String,
      json['Name'] as String,
      json['Premium'] as String?,
    );

Map<String, dynamic> _$AgAdvantageEndorsementToJson(
        AgAdvantageEndorsement instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Limit': instance.limit,
      'Name': instance.name,
      'Premium': instance.premium,
    };
