// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tfb_generic_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TfbGenericApiResponse _$TfbGenericApiResponseFromJson(
        Map<String, dynamic> json) =>
    TfbGenericApiResponse(
      errorMessage: json['ErrorMessage'] as String?,
      returnMessage: json['ReturnMessage'] as String?,
    );

Map<String, dynamic> _$TfbGenericApiResponseToJson(
        TfbGenericApiResponse instance) =>
    <String, dynamic>{
      'ErrorMessage': instance.errorMessage,
      'ReturnMessage': instance.returnMessage,
    };
