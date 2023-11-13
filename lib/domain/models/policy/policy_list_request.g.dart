// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PolicyListRequest _$PolicyListRequestFromJson(Map<String, dynamic> json) =>
    PolicyListRequest(
      policyNumber: json['PolicyNumber'] as String,
      policyType: $enumDecode(_$PolicyTypeEnumMap, json['PolicyType']),
      policySubtype: json['PolicySubType'] as String,
      locationType: json['LocationType'] as String? ?? 'POL-HIST',
    );

Map<String, dynamic> _$PolicyListRequestToJson(PolicyListRequest instance) =>
    <String, dynamic>{
      'PolicyNumber': instance.policyNumber,
      'PolicyType': _$PolicyTypeEnumMap[instance.policyType]!,
      'PolicySubType': instance.policySubtype,
      'LocationType': instance.locationType,
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
