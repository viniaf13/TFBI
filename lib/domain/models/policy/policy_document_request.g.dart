// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy_document_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PolicyDocumentRequest _$PolicyDocumentRequestFromJson(
        Map<String, dynamic> json) =>
    PolicyDocumentRequest(
      policyNumber: json['PolicyNumber'] as String,
      policyType: $enumDecode(_$PolicyTypeEnumMap, json['PolicyType']),
      policySubtype: json['PolicySubType'] as String,
      documentId: json['DocumentId'] as String,
    );

Map<String, dynamic> _$PolicyDocumentRequestToJson(
        PolicyDocumentRequest instance) =>
    <String, dynamic>{
      'PolicyNumber': instance.policyNumber,
      'PolicyType': _$PolicyTypeEnumMap[instance.policyType]!,
      'PolicySubType': instance.policySubtype,
      'DocumentId': instance.documentId,
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
