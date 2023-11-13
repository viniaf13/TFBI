// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_update_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUpdateResponse _$AppUpdateResponseFromJson(Map<String, dynamic> json) =>
    AppUpdateResponse(
      alertMessage: json['alertMessage'] as String,
      androidStoreLink: json['androidStoreLink'] as String,
      forceMessage: json['forceMessage'] as String,
      iosStoreLink: json['iosStoreLink'] as String,
      minSupportVersion: json['minimumSupportedVersion'] as String,
      recommendedVersion: json['recommendedVersion'] as String,
    );

Map<String, dynamic> _$AppUpdateResponseToJson(AppUpdateResponse instance) =>
    <String, dynamic>{
      'alertMessage': instance.alertMessage,
      'androidStoreLink': instance.androidStoreLink,
      'forceMessage': instance.forceMessage,
      'iosStoreLink': instance.iosStoreLink,
      'minimumSupportedVersion': instance.minSupportVersion,
      'recommendedVersion': instance.recommendedVersion,
    };
