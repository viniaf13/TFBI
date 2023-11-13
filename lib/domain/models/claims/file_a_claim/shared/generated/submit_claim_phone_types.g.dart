// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
part of '../submit_claim_phone_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitClaimPhoneTypes _$SubmitClaimPhoneTypesFromJson(
        Map<String, dynamic> json) =>
    SubmitClaimPhoneTypes(
      usageTypeCode: json['usageTypeCode'] as String?,
      usageTypeName: $enumDecodeNullable(
          _$PhoneTypesEnumEnumMap, json['usageTypeName'],
          unknownValue: PhoneTypesEnum.undefined),
    );

Map<String, dynamic> _$SubmitClaimPhoneTypesToJson(
        SubmitClaimPhoneTypes instance) =>
    <String, dynamic>{
      'usageTypeCode': instance.usageTypeCode,
      'usageTypeName': _$PhoneTypesEnumEnumMap[instance.usageTypeName],
    };

const _$PhoneTypesEnumEnumMap = {
  PhoneTypesEnum.busn_phn: 'Business Phone',
  PhoneTypesEnum.hm_phn: 'Home Phone',
  PhoneTypesEnum.cell_phn: 'Cellular Phone',
  PhoneTypesEnum.fax: 'Fax',
  PhoneTypesEnum.undefined: 'Undefined',
};
