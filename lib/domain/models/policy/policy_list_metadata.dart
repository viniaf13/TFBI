// coverage:ignore-file
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

part 'policy_list_metadata.g.dart';

@JsonSerializable()
class PolicyListMetadata {
  PolicyListMetadata({
    required this.date,
    required this.documentId,
    required this.formDescription,
    required this.labelDescription,
    required this.pageNumber,
    required this.versionId,
  });

  factory PolicyListMetadata.fromJson(Map<String, dynamic> json) =>
      _$PolicyListMetadataFromJson(json);
  Map<String, dynamic> toJson() => _$PolicyListMetadataToJson(this);

  @JsonKey(name: 'Date')
  String date;
  @JsonKey(name: 'DocumentId')
  String documentId;
  @JsonKey(name: 'FormDescription')
  String formDescription;
  @JsonKey(name: 'LabelDescription')
  String labelDescription;
  @JsonKey(name: 'PageNumber')
  int pageNumber;
  @JsonKey(name: 'VersionId')
  String versionId;
}
