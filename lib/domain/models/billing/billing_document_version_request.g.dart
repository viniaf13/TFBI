// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_document_version_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillingDocumentVersionRequest _$BillingDocumentVersionRequestFromJson(
        Map<String, dynamic> json) =>
    BillingDocumentVersionRequest(
      policyNumber: json['PolicyNumber'] as String,
      policyType: json['PolicyType'] as String,
      policySubType: json['PolicySubType'] as int,
      versionId: json['VersionId'] as String,
      descriptionTerm: json['DescriptionTerm'] as String,
    );

Map<String, dynamic> _$BillingDocumentVersionRequestToJson(
        BillingDocumentVersionRequest instance) =>
    <String, dynamic>{
      'PolicyNumber': instance.policyNumber,
      'PolicyType': instance.policyType,
      'PolicySubType': instance.policySubType,
      'VersionId': instance.versionId,
      'DescriptionTerm': instance.descriptionTerm,
    };
