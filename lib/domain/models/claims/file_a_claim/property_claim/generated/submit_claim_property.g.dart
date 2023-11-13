// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../submit_claim_property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyClaimSubmission _$PropertyClaimSubmissionFromJson(
        Map<String, dynamic> json) =>
    PropertyClaimSubmission(
      claimDestination: json['claimDestination'] as int?,
      claimType: json['claimType'] as String?,
      effectiveDate: json['effectiveDate'] as String?,
      expirationDate: json['expirationDate'] as String?,
      memberNumber: json['memberNumber'] as String?,
      policyNumber: json['policyNumber'] as String?,
      policySymbol: json['policySymbol'] as String?,
      policyType: json['policyType'] as String?,
      policySubType: json['policySubType'] as String?,
      externalIdValTxt: json['externalIdValTxt'] as String?,
      companyName: json['companyName'] as String?,
      corporationName: json['corporationName'] as String?,
      hasPhotos: json['hasPhotos'] as String?,
      primaryInsured: json['primaryInsured'] == null
          ? null
          : PropertyPrimaryInsured.fromJson(
              json['primaryInsured'] as Map<String, dynamic>),
      reporterInformation: json['reporterInformation'] == null
          ? null
          : ReporterInformation.fromJson(
              json['reporterInformation'] as Map<String, dynamic>),
      lossInformation: json['lossInformation'] == null
          ? null
          : LossInformation.fromJson(
              json['lossInformation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PropertyClaimSubmissionToJson(
        PropertyClaimSubmission instance) =>
    <String, dynamic>{
      'claimDestination': instance.claimDestination,
      'claimType': instance.claimType,
      'effectiveDate': instance.effectiveDate,
      'expirationDate': instance.expirationDate,
      'memberNumber': instance.memberNumber,
      'policyNumber': instance.policyNumber,
      'policySymbol': instance.policySymbol,
      'policyType': instance.policyType,
      'policySubType': instance.policySubType,
      'externalIdValTxt': instance.externalIdValTxt,
      'companyName': instance.companyName,
      'corporationName': instance.corporationName,
      'hasPhotos': instance.hasPhotos,
      'primaryInsured': instance.primaryInsured,
      'reporterInformation': instance.reporterInformation,
      'lossInformation': instance.lossInformation,
    };
