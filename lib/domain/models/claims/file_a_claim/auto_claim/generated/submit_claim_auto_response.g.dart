// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../submit_claim_auto_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutoClaimSubmissionResponse _$AutoClaimSubmissionResponseFromJson(
        Map<String, dynamic> json) =>
    AutoClaimSubmissionResponse(
      referenceNumber: json['ReferenceNumber'] as String,
      claimNumber: json['claimNumber'] as String?,
      submissionStatus: json['SubmissionStatus'] as String,
      adjuster: json['Adjuster'] == null
          ? null
          : Adjuster.fromJson(json['Adjuster'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AutoClaimSubmissionResponseToJson(
        AutoClaimSubmissionResponse instance) =>
    <String, dynamic>{
      'ReferenceNumber': instance.referenceNumber,
      'claimNumber': instance.claimNumber,
      'SubmissionStatus': instance.submissionStatus,
      'Adjuster': instance.adjuster,
    };

Adjuster _$AdjusterFromJson(Map<String, dynamic> json) => Adjuster(
      email: json['Email'] as String,
      id: json['Id'] as String?,
      name: json['Name'] as String,
      office: json['Office'] == null
          ? null
          : Office.fromJson(json['Office'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdjusterToJson(Adjuster instance) => <String, dynamic>{
      'Email': instance.email,
      'Id': instance.id,
      'Name': instance.name,
      'Office': instance.office,
    };

Office _$OfficeFromJson(Map<String, dynamic> json) => Office(
      number: json['Number'] as String,
      phone: json['Phone'] as String?,
    );

Map<String, dynamic> _$OfficeToJson(Office instance) => <String, dynamic>{
      'Number': instance.number,
      'Phone': instance.phone,
    };
