// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy_static_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PolicyStaticDocument _$PolicyStaticDocumentFromJson(
        Map<String, dynamic> json) =>
    PolicyStaticDocument(
      documentId: json['DocumentId'] as int,
      documentTitle: json['DocumentTitle'] as String,
      documentType: json['DocumentType'] as String,
      documentUrl: json['DocumentUrl'] as String,
    );

Map<String, dynamic> _$PolicyStaticDocumentToJson(
        PolicyStaticDocument instance) =>
    <String, dynamic>{
      'DocumentId': instance.documentId,
      'DocumentTitle': instance.documentTitle,
      'DocumentType': instance.documentType,
      'DocumentUrl': instance.documentUrl,
    };
