// coverage:ignore-file

import 'package:txfb_insurance_flutter/data/data.dart';

part 'generated/submit_claim_name.g.dart';

@JsonSerializable()
class SubmitClaimName {
  const SubmitClaimName({
    this.firstName,
    this.lastName,
    this.suffix,
    this.displayName,
  });

  factory SubmitClaimName.fromJson(Map<String, dynamic> json) =>
      _$SubmitClaimNameFromJson(json);
  Map<String, dynamic> toJson() => _$SubmitClaimNameToJson(this);

  @JsonKey(name: 'FirstName')
  final String? firstName;
  @JsonKey(name: 'LastName')
  final String? lastName;
  @JsonKey(name: 'Suffix')
  final String? suffix;
  @JsonKey(name: 'DisplayName')
  final String? displayName;

  SubmitClaimName copyWith({
    String? firstName,
    String? lastName,
    String? suffix,
    String? displayName,
  }) =>
      SubmitClaimName(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        suffix: suffix ?? this.suffix,
        displayName: displayName ?? this.displayName,
      );
}
