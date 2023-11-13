// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberAddress _$MemberAddressFromJson(Map<String, dynamic> json) =>
    MemberAddress(
      addressLine1: json['AddressLine1'] as String?,
      addressLine2: json['AddressLine2'] as String?,
      city: json['City'] as String?,
      state: json['State'] as String?,
      zipcode: json['Zipcode'] as String?,
      zipcode2: json['Zipcode2'] as String?,
      zipcode4: json['Zipcode4'] as String?,
    );

Map<String, dynamic> _$MemberAddressToJson(MemberAddress instance) =>
    <String, dynamic>{
      'AddressLine1': instance.addressLine1,
      'AddressLine2': instance.addressLine2,
      'City': instance.city,
      'State': instance.state,
      'Zipcode': instance.zipcode,
      'Zipcode2': instance.zipcode2,
      'Zipcode4': instance.zipcode4,
    };
