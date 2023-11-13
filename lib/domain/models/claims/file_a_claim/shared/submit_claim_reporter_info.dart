// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';

part 'generated/submit_claim_reporter_info.g.dart';

@JsonSerializable()
class ReporterInformation {
  const ReporterInformation({
    this.name,
    this.reporterType,
    this.phoneNumber,
    this.phoneType,
    this.emailAddress,
    this.reportingSource,
  });

  factory ReporterInformation.fromJson(Map<String, dynamic> json) =>
      _$ReporterInformationFromJson(json);
  Map<String, dynamic> toJson() => _$ReporterInformationToJson(this);

  final String? name;
  @JsonKey(name: 'type')
  final String? reporterType;
  final String? phoneNumber;
  @JsonKey(name: 'phoneType')
  final String? phoneType;
  final String? emailAddress;
  final int? reportingSource;

  ReporterInformation copyWith({
    String? name,
    String? reporterType,
    String? phoneNumber,
    String? phoneType,
    String? emailAddress,
    int? reportingSource,
  }) =>
      ReporterInformation(
        name: name ?? this.name,
        reporterType: reporterType ?? this.reporterType,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        phoneType: phoneType ?? this.phoneType,
        emailAddress: emailAddress ?? this.emailAddress,
        reportingSource: reportingSource ?? this.reportingSource,
      );
}
