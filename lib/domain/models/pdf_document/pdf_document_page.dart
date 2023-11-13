// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';

part 'pdf_document_page.g.dart';

@JsonSerializable()
class PdfDocumentPage {
  PdfDocumentPage({
    required this.content,
  });

  factory PdfDocumentPage.fromJson(Map<String, dynamic> json) =>
      _$PdfDocumentPageFromJson(json);

  Map<String, dynamic> toJson() => _$PdfDocumentPageToJson(this);

  final String content;

  PdfDocumentPage copy() {
    return PdfDocumentPage(
      content: content,
    );
  }

  @override
  String toString() {
    String returnStr = '';
    returnStr += 'content: $content\n';
    return returnStr;
  }
}
