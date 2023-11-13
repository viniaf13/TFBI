// coverage:ignore-file
import 'package:json_annotation/json_annotation.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/enum/property_loss_types_enum.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/loss_types.dart';

part 'generated/submit_claim_property_loss_types.g.dart';

@JsonSerializable()
class SubmitClaimPropertyLossTypes extends LossTypes {
  SubmitClaimPropertyLossTypes({
    this.lob,
    this.code,
    this.name,
    this.shortName,
  });

  factory SubmitClaimPropertyLossTypes.fromJson(Map<String, dynamic> json) =>
      _$SubmitClaimPropertyLossTypesFromJson(json);
  Map<String, dynamic> toJson() => _$SubmitClaimPropertyLossTypesToJson(this);

  final String? lob;
  final String? code;
  @JsonKey(name: 'name', unknownEnumValue: PropertyLossTypesEnum.undefined)
  final PropertyLossTypesEnum? name;
  final String? shortName;

  SubmitClaimPropertyLossTypes copyWith({
    String? lob,
    String? code,
    PropertyLossTypesEnum? name,
    String? shortName,
  }) =>
      SubmitClaimPropertyLossTypes(
        lob: lob ?? this.lob,
        code: code ?? this.code,
        name: name ?? this.name,
        shortName: shortName ?? this.shortName,
      );

  @override
  String? get displayName => name?.value;

  @override
  String toString() {
    return '$name -- $code';
  }
}
