// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
      contactId: json['ContactId'] as String,
      miraId: json['MiraId'] as int,
      fullName: json['FullName'] as String,
      phoneNumber: json['PhoneNumber'] as String,
      textEnabled: json['TextEnabled'] as bool,
      verified: json['Verified'] as bool,
    );

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'ContactId': instance.contactId,
      'MiraId': instance.miraId,
      'FullName': instance.fullName,
      'PhoneNumber': instance.phoneNumber,
      'TextEnabled': instance.textEnabled,
      'Verified': instance.verified,
    };
