// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_document_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PdfDocumentMetadata _$PdfDocumentMetadataFromJson(Map<String, dynamic> json) =>
    PdfDocumentMetadata(
      mimeType: json['mimeType'] as String,
      pages: (json['pages'] as List<dynamic>)
          .map((e) => PdfDocumentPage.fromJson(e as Map<String, dynamic>))
          .toList(),
      rotation: json['rotation'] as int,
      scale: json['scale'] as int,
      supportedMimeTypes: (json['supportedMimeTypes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      width: json['width'] as int,
    );

Map<String, dynamic> _$PdfDocumentMetadataToJson(
        PdfDocumentMetadata instance) =>
    <String, dynamic>{
      'mimeType': instance.mimeType,
      'pages': instance.pages,
      'rotation': instance.rotation,
      'scale': instance.scale,
      'supportedMimeTypes': instance.supportedMimeTypes,
      'width': instance.width,
    };
