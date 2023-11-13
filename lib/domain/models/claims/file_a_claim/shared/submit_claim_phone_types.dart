// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/enum/phone_types_enum.dart';

part 'generated/submit_claim_phone_types.g.dart';

@JsonSerializable()
class SubmitClaimPhoneTypes {
  SubmitClaimPhoneTypes({
    this.usageTypeCode,
    this.usageTypeName,
  });

  factory SubmitClaimPhoneTypes.fromJson(Map<String, dynamic> json) =>
      _$SubmitClaimPhoneTypesFromJson(json);
  Map<String, dynamic> toJson() => _$SubmitClaimPhoneTypesToJson(this);

  final String? usageTypeCode;
  @JsonKey(name: 'usageTypeName', unknownEnumValue: PhoneTypesEnum.undefined)
  final PhoneTypesEnum? usageTypeName;

  SubmitClaimPhoneTypes copyWith({
    String? usageTypeCode,
    PhoneTypesEnum? usageTypeName,
  }) =>
      SubmitClaimPhoneTypes(
        usageTypeCode: usageTypeCode ?? this.usageTypeCode,
        usageTypeName: usageTypeName ?? this.usageTypeName,
      );

  @override
  String toString() {
    return '$usageTypeName($usageTypeCode)';
  }
}
