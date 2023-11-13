// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy_list_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PolicyListMetadata _$PolicyListMetadataFromJson(Map<String, dynamic> json) =>
    PolicyListMetadata(
      date: json['Date'] as String,
      documentId: json['DocumentId'] as String,
      formDescription: json['FormDescription'] as String,
      labelDescription: json['LabelDescription'] as String,
      pageNumber: json['PageNumber'] as int,
      versionId: json['VersionId'] as String,
    );

Map<String, dynamic> _$PolicyListMetadataToJson(PolicyListMetadata instance) =>
    <String, dynamic>{
      'Date': instance.date,
      'DocumentId': instance.documentId,
      'FormDescription': instance.formDescription,
      'LabelDescription': instance.labelDescription,
      'PageNumber': instance.pageNumber,
      'VersionId': instance.versionId,
    };
