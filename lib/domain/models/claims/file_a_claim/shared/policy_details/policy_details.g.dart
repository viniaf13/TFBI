// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PolicyDetails _$PolicyDetailsFromJson(Map<String, dynamic> json) =>
    PolicyDetails(
      drivers: (json['Drivers'] as List<dynamic>?)
          ?.map((e) => Drivers.fromJson(e as Map<String, dynamic>))
          .toList(),
      vehicles: (json['Vehicles'] as List<dynamic>?)
          ?.map((e) => Vehicles.fromJson(e as Map<String, dynamic>))
          .toList(),
      claimDestination: json['ClaimDestination'] as int?,
      claimType: json['ClaimType'] as int?,
      dateOfLoss: json['DateOfLoss'] as String?,
      effectiveDate: json['EffectiveDate'] as String?,
      expirationDate: json['ExpirationDate'] as String?,
      memberNumber: json['MemberNumber'] as String?,
      policyNumber: json['PolicyNumber'] as String?,
      policySymbol: json['PolicySymbol'] as String?,
      policyTypeCrm: json['PolicyTypeCrm'] as String?,
      policyType: json['PolicyType'] as String?,
      policySubType: json['PolicySubType'] as String?,
      originalEffectiveDate: json['OriginalEffectiveDate'] as String?,
      externalIdValTxt: json['ExternalIdValTxt'] as String?,
      companyName: json['CompanyName'] as String?,
      corporationName: json['CorporationName'] as String?,
      primaryInsured: json['PrimaryInsured'] == null
          ? null
          : PrimaryInsured.fromJson(
              json['PrimaryInsured'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PolicyDetailsToJson(PolicyDetails instance) =>
    <String, dynamic>{
      'Drivers': instance.drivers,
      'Vehicles': instance.vehicles,
      'ClaimDestination': instance.claimDestination,
      'ClaimType': instance.claimType,
      'DateOfLoss': instance.dateOfLoss,
      'EffectiveDate': instance.effectiveDate,
      'ExpirationDate': instance.expirationDate,
      'MemberNumber': instance.memberNumber,
      'PolicyNumber': instance.policyNumber,
      'PolicySymbol': instance.policySymbol,
      'PolicyTypeCrm': instance.policyTypeCrm,
      'PolicyType': instance.policyType,
      'PolicySubType': instance.policySubType,
      'OriginalEffectiveDate': instance.originalEffectiveDate,
      'ExternalIdValTxt': instance.externalIdValTxt,
      'CompanyName': instance.companyName,
      'CorporationName': instance.corporationName,
      'PrimaryInsured': instance.primaryInsured,
    };
