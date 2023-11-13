// coverage:ignore-file
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

part 'billing_list_metadata.g.dart';

@JsonSerializable()
class BillingListMetadata {
  BillingListMetadata({
    required this.date,
    required this.documentId,
    required this.formDescription,
    required this.labelDescription,
    required this.pageNumber,
    required this.versionId,
  });

  factory BillingListMetadata.fromJson(Map<String, dynamic> json) =>
      _$BillingListMetadataFromJson(json);
  Map<String, dynamic> toJson() => _$BillingListMetadataToJson(this);

  @JsonKey(name: 'Date')
  final String date;
  @JsonKey(name: 'DocumentId')
  final String documentId;
  @JsonKey(name: 'FormDescription')
  final String formDescription;
  @JsonKey(name: 'LabelDescription')
  final String labelDescription;
  @JsonKey(name: 'PageNumber')
  final int pageNumber;
  @JsonKey(name: 'VersionId')
  final String versionId;
}
