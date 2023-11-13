// coverage:ignore-file
import 'package:json_annotation/json_annotation.dart';

part 'generated/submit_claim_property_response.g.dart';

@JsonSerializable()
class PropertyClaimSubmissionResponse {
  PropertyClaimSubmissionResponse({
    required this.referenceNumber,
    required this.claimNumber,
    required this.submissionStatus,
    required this.adjuster,
  });

  factory PropertyClaimSubmissionResponse.fromJson(Map<String, dynamic> json) =>
      _$PropertyClaimSubmissionResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$PropertyClaimSubmissionResponseToJson(this);

  @JsonKey(name: 'ReferenceNumber')
  final String referenceNumber;
  @JsonKey(name: 'claimNumber')
  final String? claimNumber;
  @JsonKey(name: 'SubmissionStatus')
  final String submissionStatus;
  @JsonKey(name: 'Adjuster')
  final String? adjuster;
}
