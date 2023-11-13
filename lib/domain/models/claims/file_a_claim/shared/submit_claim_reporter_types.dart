// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/enum/reporter_types_enum.dart';

part 'generated/submit_claim_reporter_types.g.dart';

@JsonSerializable()
class SubmitClaimReporterTypes {
  const SubmitClaimReporterTypes({
    this.key,
    this.value,
  });

  factory SubmitClaimReporterTypes.fromJson(Map<String, dynamic> json) =>
      _$SubmitClaimReporterTypesFromJson(json);
  Map<String, dynamic> toJson() => _$SubmitClaimReporterTypesToJson(this);

  @JsonKey(name: 'Key')
  final String? key;
  @JsonKey(name: 'Value', unknownEnumValue: ReporterTypesEnum.undefined)
  final ReporterTypesEnum? value;

  SubmitClaimReporterTypes copyWith({
    String? key,
    ReporterTypesEnum? value,
  }) =>
      SubmitClaimReporterTypes(
        key: key ?? key,
        value: value ?? value,
      );

  @override
  String toString() {
    return '${value?.value}';
  }
}
