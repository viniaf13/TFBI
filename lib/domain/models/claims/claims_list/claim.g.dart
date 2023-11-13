// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Claim _$ClaimFromJson(Map<String, dynamic> json) => Claim(
      claimNumber: json['ClaimNumber'] as String?,
      claimStatus: $enumDecodeNullable(
          _$ClaimStatusEnumEnumMap, json['ClaimStatus'],
          unknownValue: ClaimStatusEnum.undefinedClaimStatus),
      policyNumber: json['PolicyNumber'] as String?,
      policyType: $enumDecodeNullable(_$PolicyTypeEnumMap, json['PolicyType'],
          unknownValue: PolicyType.unsupportedPolicy),
      dateOfLoss: json['DateOfLoss'] as String?,
    );

Map<String, dynamic> _$ClaimToJson(Claim instance) => <String, dynamic>{
      'ClaimNumber': instance.claimNumber,
      'ClaimStatus': _$ClaimStatusEnumEnumMap[instance.claimStatus],
      'PolicyNumber': instance.policyNumber,
      'PolicyType': _$PolicyTypeEnumMap[instance.policyType],
      'DateOfLoss': instance.dateOfLoss,
    };

const _$ClaimStatusEnumEnumMap = {
  ClaimStatusEnum.active: 'OPEN',
  ClaimStatusEnum.inactive: 'CLOSED',
  ClaimStatusEnum.undefinedClaimStatus: 'UNDEFINED',
};

const _$PolicyTypeEnumMap = {
  PolicyType.agAdvantage: 'AA',
  PolicyType.homeowners: 'HT',
  PolicyType.inlandMarine: 'PF',
  PolicyType.lifeAndEndowment: 'LI',
  PolicyType.txPersonalAuto: 'SM',
  PolicyType.umbrella: 'UM',
  PolicyType.unsupportedPolicy: '',
};
