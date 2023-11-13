// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy_static_documents_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PolicyStaticDocumentsRequest _$PolicyStaticDocumentsRequestFromJson(
        Map<String, dynamic> json) =>
    PolicyStaticDocumentsRequest(
      expirationDate: json['ExpirationDate'] as String,
      policySymbol: json['PolicySymbol'] as String,
    );

Map<String, dynamic> _$PolicyStaticDocumentsRequestToJson(
        PolicyStaticDocumentsRequest instance) =>
    <String, dynamic>{
      'PolicySymbol': instance.policySymbol,
      'ExpirationDate': instance.expirationDate,
    };
