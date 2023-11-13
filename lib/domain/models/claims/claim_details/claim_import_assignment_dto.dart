// coverage:ignore-file
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';

part 'claim_import_assignment_dto.g.dart';

@JsonSerializable()
class ClaimImportAssignmentDTO {
  ClaimImportAssignmentDTO({
    this.userPhoneNumber,
    this.userPhoneExtension,
    this.userEmail,
    this.userFirstName,
    this.userLastName,
    this.userAddress,
    this.userCity,
    this.userState,
    this.userZipCode,
    this.userPhoto,
  });

  factory ClaimImportAssignmentDTO.fromJson(Map<String, dynamic> json) =>
      _$ClaimImportAssignmentDTOFromJson(json);
  Map<String, dynamic> toJson() => _$ClaimImportAssignmentDTOToJson(this);

  @JsonKey(name: 'userPhoneNumber')
  final String? userPhoneNumber;
  @JsonKey(name: 'userPhoneExtension')
  final String? userPhoneExtension;
  @JsonKey(name: 'userEmail')
  final String? userEmail;
  @JsonKey(name: 'userFirstName')
  final String? userFirstName;
  @JsonKey(name: 'userLastName')
  final String? userLastName;
  @JsonKey(name: 'userAddresss')

  /// typo returned from api; do not change ///
  final String? userAddress;
  @JsonKey(name: 'userCity')
  final String? userCity;
  @JsonKey(name: 'userState')
  final String? userState;
  @JsonKey(name: 'userZipCode')
  final String? userZipCode;
  @JsonKey(name: 'userPhoto')
  final String? userPhoto;

  ClaimImportAssignmentDTO copyWith({
    String? userPhoneNumber,
    String? userPhoneExtension,
    String? userEmail,
    String? userFirstName,
    String? userLastName,
    String? userAddresss,
    String? userCity,
    String? userState,
    String? userZipCode,
    String? userPhoto,
  }) =>
      ClaimImportAssignmentDTO(
        userPhoneNumber: userPhoneNumber ?? this.userPhoneNumber,
        userPhoneExtension: userPhoneExtension ?? this.userPhoneExtension,
        userEmail: userEmail ?? this.userEmail,
        userFirstName: userFirstName ?? this.userFirstName,
        userLastName: userLastName ?? this.userLastName,
        userAddress: userAddresss ?? userAddress,
        userCity: userCity ?? this.userCity,
        userState: userState ?? this.userState,
        userZipCode: userZipCode ?? this.userZipCode,
        userPhoto: userPhoto ?? this.userPhoto,
      );
}
