// coverage:ignore-file
import 'package:txfb_insurance_flutter/domain/models/pdf_document/pdf_document_page.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

part 'pdf_document_metadata.g.dart';

@JsonSerializable()
class PdfDocumentMetadata {
  PdfDocumentMetadata({
    required this.mimeType,
    required this.pages,
    required this.rotation,
    required this.scale,
    required this.supportedMimeTypes,
    required this.width,
  });

  factory PdfDocumentMetadata.fromJson(Map<String, dynamic> json) =>
      _$PdfDocumentMetadataFromJson(json);
  Map<String, dynamic> toJson() => _$PdfDocumentMetadataToJson(this);

  @JsonKey(name: 'mimeType')
  final String mimeType;
  @JsonKey(name: 'pages')
  final List<PdfDocumentPage> pages;
  @JsonKey(name: 'rotation')
  final int rotation;
  @JsonKey(name: 'scale')
  final int scale;
  @JsonKey(name: 'supportedMimeTypes')
  final List<String> supportedMimeTypes;
  @JsonKey(name: 'width')
  final int width;
}
