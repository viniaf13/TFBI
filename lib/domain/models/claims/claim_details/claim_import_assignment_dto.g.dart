// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_import_assignment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimImportAssignmentDTO _$ClaimImportAssignmentDTOFromJson(
        Map<String, dynamic> json) =>
    ClaimImportAssignmentDTO(
      userPhoneNumber: json['userPhoneNumber'] as String?,
      userPhoneExtension: json['userPhoneExtension'] as String?,
      userEmail: json['userEmail'] as String?,
      userFirstName: json['userFirstName'] as String?,
      userLastName: json['userLastName'] as String?,
      userAddress: json['userAddresss'] as String?,
      userCity: json['userCity'] as String?,
      userState: json['userState'] as String?,
      userZipCode: json['userZipCode'] as String?,
      userPhoto: json['userPhoto'] as String?,
    );

Map<String, dynamic> _$ClaimImportAssignmentDTOToJson(
        ClaimImportAssignmentDTO instance) =>
    <String, dynamic>{
      'userPhoneNumber': instance.userPhoneNumber,
      'userPhoneExtension': instance.userPhoneExtension,
      'userEmail': instance.userEmail,
      'userFirstName': instance.userFirstName,
      'userLastName': instance.userLastName,
      'userAddresss': instance.userAddress,
      'userCity': instance.userCity,
      'userState': instance.userState,
      'userZipCode': instance.userZipCode,
      'userPhoto': instance.userPhoto,
    };
