// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../submit_claim_property_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyClaimSubmissionResponse _$PropertyClaimSubmissionResponseFromJson(
        Map<String, dynamic> json) =>
    PropertyClaimSubmissionResponse(
      referenceNumber: json['ReferenceNumber'] as String,
      claimNumber: json['claimNumber'] as String?,
      submissionStatus: json['SubmissionStatus'] as String,
      adjuster: json['Adjuster'] as String?,
    );

Map<String, dynamic> _$PropertyClaimSubmissionResponseToJson(
        PropertyClaimSubmissionResponse instance) =>
    <String, dynamic>{
      'ReferenceNumber': instance.referenceNumber,
      'claimNumber': instance.claimNumber,
      'SubmissionStatus': instance.submissionStatus,
      'Adjuster': instance.adjuster,
    };
