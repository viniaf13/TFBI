// coverage:ignore-file
import 'package:json_annotation/json_annotation.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/enum/auto_loss_types_enum.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/loss_types.dart';

part 'generated/submit_claim_auto_loss_types.g.dart';

@JsonSerializable()
class SubmitClaimAutoLossTypes extends LossTypes {
  SubmitClaimAutoLossTypes({
    this.lob,
    this.code,
    this.name,
    this.shortName,
  });

  factory SubmitClaimAutoLossTypes.fromJson(Map<String, dynamic> json) =>
      _$SubmitClaimAutoLossTypesFromJson(json);
  Map<String, dynamic> toJson() => _$SubmitClaimAutoLossTypesToJson(this);

  final String? lob;
  final String? code;
  @JsonKey(name: 'name', unknownEnumValue: AutoLossTypesEnum.undefined)
  final AutoLossTypesEnum? name;
  final String? shortName;

  SubmitClaimAutoLossTypes copyWith({
    String? lob,
    String? code,
    AutoLossTypesEnum? name,
    String? shortName,
  }) =>
      SubmitClaimAutoLossTypes(
        lob: lob ?? this.lob,
        code: code ?? this.code,
        name: name ?? this.name,
        shortName: shortName ?? this.shortName,
      );

  @override
  String? get displayName => name?.value;

  @override
  String toString() {
    return '${name?.value}($code)';
  }
}
