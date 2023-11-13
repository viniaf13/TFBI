// coverage:ignore-file
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

part 'policy_static_document.g.dart';

@JsonSerializable()
class PolicyStaticDocument {
  PolicyStaticDocument({
    required this.documentId,
    required this.documentTitle,
    required this.documentType,
    required this.documentUrl,
  });

  factory PolicyStaticDocument.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PolicyStaticDocumentFromJson(json);
  Map<String, dynamic> toJson() => _$PolicyStaticDocumentToJson(this);

  @JsonKey(name: 'DocumentId')
  int documentId;
  @JsonKey(name: 'DocumentTitle')
  String documentTitle;
  @JsonKey(name: 'DocumentType')
  String documentType;
  @JsonKey(name: 'DocumentUrl')
  String documentUrl;
}
