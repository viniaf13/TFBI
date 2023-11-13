// coverage:ignore-file
import 'package:json_annotation/json_annotation.dart';

part 'generated/submit_claim_auto_response.g.dart';

@JsonSerializable()
class AutoClaimSubmissionResponse {
  AutoClaimSubmissionResponse({
    required this.referenceNumber,
    required this.claimNumber,
    required this.submissionStatus,
    required this.adjuster,
  });

  factory AutoClaimSubmissionResponse.fromJson(Map<String, dynamic> json) =>
      _$AutoClaimSubmissionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AutoClaimSubmissionResponseToJson(this);

  @JsonKey(name: 'ReferenceNumber')
  final String referenceNumber;
  @JsonKey(name: 'claimNumber')
  final String? claimNumber;
  @JsonKey(name: 'SubmissionStatus')
  final String submissionStatus;
  @JsonKey(name: 'Adjuster')
  final Adjuster? adjuster;
}

@JsonSerializable()
class Adjuster {
  Adjuster({
    required this.email,
    required this.id,
    required this.name,
    required this.office,
  });

  factory Adjuster.fromJson(Map<String, dynamic> json) =>
      _$AdjusterFromJson(json);
  Map<String, dynamic> toJson() => _$AdjusterToJson(this);

  @JsonKey(name: 'Email')
  final String email;
  @JsonKey(name: 'Id')
  final String? id;
  @JsonKey(name: 'Name')
  final String name;
  @JsonKey(name: 'Office')
  final Office? office;
}

@JsonSerializable()
class Office {
  Office({
    required this.number,
    required this.phone,
  });

  factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);
  Map<String, dynamic> toJson() => _$OfficeToJson(this);

  @JsonKey(name: 'Number')
  final String number;
  @JsonKey(name: 'Phone')
  final String? phone;
}
