// coverage:ignore-file

import 'package:txfb_insurance_flutter/data/data.dart';

part 'generated/submit_claim_owner_information.g.dart';

@JsonSerializable()
class OwnerInformation {
  const OwnerInformation({
    this.firstName,
    this.lastName,
    this.objectId,
  });

  factory OwnerInformation.fromJson(Map<String, dynamic> json) =>
      _$OwnerInformationFromJson(json);
  Map<String, dynamic> toJson() => _$OwnerInformationToJson(this);

  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  @JsonKey(name: 'objectId')
  final String? objectId;

  OwnerInformation copyWith({
    String? firstName,
    String? lastName,
    String? objectId,
  }) =>
      OwnerInformation(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        objectId: objectId ?? this.objectId,
      );
}
