// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homeowner_policy_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeownerPolicyDetail _$HomeownerPolicyDetailFromJson(
        Map<String, dynamic> json) =>
    HomeownerPolicyDetail(
      json['PropertyLocation'] as String,
      json['PropertyConstruction'] as String,
      json['PolicyForm'] as String,
      (json['Sections'] as List<dynamic>)
          .map((e) => HomeownerSection.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$HomeownerPolicyDetailToJson(
        HomeownerPolicyDetail instance) =>
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

HomeownerSection _$HomeownerSectionFromJson(Map<String, dynamic> json) =>
    HomeownerSection(
      json['Name'] as String,
      (json['Coverages'] as List<dynamic>)
          .map((e) => HomeownerCoverage.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['Deductibles'] as List<dynamic>)
          .map((e) => HomeownerDeductible.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['Discounts'] as List<dynamic>)
          .map((e) => HomeownerDiscount.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['Endorsements'] as List<dynamic>)
          .map((e) => HomeownerEndorsement.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['Mortgagees'] as List<dynamic>)
          .map((e) => Mortgagee.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeownerSectionToJson(HomeownerSection instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Coverages': instance.coverages,
      'Deductibles': instance.deductibles,
      'Discounts': instance.discounts,
      'Endorsements': instance.endorsements,
      'Mortgagees': instance.mortgagees,
    };

HomeownerCoverage _$HomeownerCoverageFromJson(Map<String, dynamic> json) =>
    HomeownerCoverage(
      json['Id'] as String,
      json['Group'] as String,
      json['Limit'] as String,
      json['Name'] as String,
      json['ObjectSequenceNumber'] as String,
      json['ObjectType'] as String,
      json['Premium'] as String,
    );

Map<String, dynamic> _$HomeownerCoverageToJson(HomeownerCoverage instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Group': instance.group,
      'Limit': instance.limit,
      'Name': instance.name,
      'ObjectSequenceNumber': instance.objectSequenceNumber,
      'ObjectType': instance.objectType,
      'Premium': instance.premium,
    };

HomeownerDeductible _$HomeownerDeductibleFromJson(Map<String, dynamic> json) =>
    HomeownerDeductible(
      json['Amount'] as String,
      json['Id'] as String,
      json['Name'] as String,
      json['ObjectSequenceNumber'] as String,
      json['ObjectType'] as String,
    );

Map<String, dynamic> _$HomeownerDeductibleToJson(
        HomeownerDeductible instance) =>
    <String, dynamic>{
      'Amount': instance.amount,
      'Id': instance.id,
      'Name': instance.name,
      'ObjectSequenceNumber': instance.objectSequenceNumber,
      'ObjectType': instance.objectType,
    };

HomeownerDiscount _$HomeownerDiscountFromJson(Map<String, dynamic> json) =>
    HomeownerDiscount(
      json['Name'] as String,
      json['Value'] as String,
    );

Map<String, dynamic> _$HomeownerDiscountToJson(HomeownerDiscount instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Value': instance.value,
    };

HomeownerEndorsement _$HomeownerEndorsementFromJson(
        Map<String, dynamic> json) =>
    HomeownerEndorsement(
      json['Id'] as String,
      json['Limit'] as String,
      json['Name'] as String,
      json['Premium'] as String,
    );

Map<String, dynamic> _$HomeownerEndorsementToJson(
        HomeownerEndorsement instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Limit': instance.limit,
      'Name': instance.name,
      'Premium': instance.premium,
    };
