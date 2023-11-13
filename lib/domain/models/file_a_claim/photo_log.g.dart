// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoLog _$PhotoLogFromJson(Map<String, dynamic> json) => PhotoLog(
      logs: (json['logs'] as List<dynamic>)
          .map((e) => PhotoRegister.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PhotoLogToJson(PhotoLog instance) => <String, dynamic>{
      'logs': instance.logs,
    };

PhotoRegister _$PhotoRegisterFromJson(Map<String, dynamic> json) =>
    PhotoRegister(
      dateTime: json['dateTime'] as String,
      photoName: json['photoName'] as String,
      response: json['response'] as String,
      numberOfRetries: json['numberOfRetries'] as int,
    );

Map<String, dynamic> _$PhotoRegisterToJson(PhotoRegister instance) =>
    <String, dynamic>{
      'dateTime': instance.dateTime,
      'photoName': instance.photoName,
      'response': instance.response,
      'numberOfRetries': instance.numberOfRetries,
    };
