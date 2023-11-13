// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'endorsements.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Endorsements _$EndorsementsFromJson(Map<String, dynamic> json) => Endorsements(
      id: json['Id'] as String?,
      number: json['Number'] as String?,
      name: json['Name'] as String?,
    );

Map<String, dynamic> _$EndorsementsToJson(Endorsements instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Number': instance.number,
      'Name': instance.name,
    };
