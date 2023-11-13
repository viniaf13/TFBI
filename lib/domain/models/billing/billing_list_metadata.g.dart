// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_list_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillingListMetadata _$BillingListMetadataFromJson(Map<String, dynamic> json) =>
    BillingListMetadata(
      date: json['Date'] as String,
      documentId: json['DocumentId'] as String,
      formDescription: json['FormDescription'] as String,
      labelDescription: json['LabelDescription'] as String,
      pageNumber: json['PageNumber'] as int,
      versionId: json['VersionId'] as String,
    );

Map<String, dynamic> _$BillingListMetadataToJson(
        BillingListMetadata instance) =>
    <String, dynamic>{
      'Date': instance.date,
      'DocumentId': instance.documentId,
      'FormDescription': instance.formDescription,
      'LabelDescription': instance.labelDescription,
      'PageNumber': instance.pageNumber,
      'VersionId': instance.versionId,
    };
