// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimDto _$ClaimDtoFromJson(Map<String, dynamic> json) => ClaimDto(
      literalDescriptionMap: json['literalDescriptionMap'] == null
          ? null
          : ClaimLiteralDescriptionMap.fromJson(
              json['literalDescriptionMap'] as Map<String, dynamic>),
      recordId: json['recordId'] as String?,
      version: json['version'] as String?,
      updated: json['updated'] as String?,
      childUpdated: json['childUpdated'] as String?,
      dtoUtilsSynchronized: json['dtoUtilsSynchronized'] as String?,
      userIdCreated: json['userIdCreated'] as String?,
      createdDateTime: json['createdDateTime'] as String?,
      userIdUpdated: json['userIdUpdated'] as String?,
      updatedDateTime: json['updatedDateTime'] as String?,
      delInd: json['delInd'] as String?,
      claimTypeCode: json['claimTypeCode'] as String?,
      jurisdictionId: json['jurisdictionId'] as String?,
      notificationPhoneTypeCode: json['notificationPhoneTypeCode'] as String?,
      notificationPhoneNumber: json['notificationPhoneNumber'] as String?,
      notificationSourceCode: json['notificationSourceCode'] as String?,
      notificationMethodCode: json['notificationMethodCode'] as String?,
      lossDateTimeZoneCode: json['lossDateTimeZoneCode'] as String?,
      notificationDateTimeZoneCode:
          json['notificationDateTimeZoneCode'] as String?,
      claimNumber: json['claimNumber'] as String?,
      callerName: json['callerName'] as String?,
      lossDescription: json['lossDescription'] as String?,
      dateOfLossDate: json['dateOfLossDate'] as String?,
      notificationDate: json['notificationDate'] as String?,
      lossDateTime: json['lossDateTime'] as String?,
      notificationTime: json['notificationTime'] as String?,
      catManualFlag: json['catManualFlag'] as String?,
      claimSourceCode: json['claimSourceCode'] as String?,
      companyLobId: json['companyLobId'] as String?,
      lobCode: json['lobCode'] as String?,
      unverifiedPolicy: json['unverifiedPolicy'] as String?,
      occurrenceDateVerifyIndicator:
          json['occurrenceDateVerifyIndicator'] as String?,
      claimPolicyNumber: json['claimPolicyNumber'] as String?,
      causeOfLossCode: json['causeOfLossCode'] as String?,
      coverages: json['coverages'] as String?,
      calClaimReportDate: json['calClaimReportDate'] as String?,
      claimAliasNumbers: json['claimAliasNumbers'] as String?,
      reinsuranceRetentionDetail: json['reinsuranceRetentionDetail'] as String?,
      claimJurisdictionProfiles: json['claimJurisdictionProfiles'] as String?,
      claimLossProfiles: json['claimLossProfiles'] as String?,
      claimLossIndicatorProfiles: json['claimLossIndicatorProfiles'] as String?,
      claimPolicyIndicatorProfiles:
          json['claimPolicyIndicatorProfiles'] as String?,
      clmAddress: (json['clmAddress'] as List<dynamic>?)
          ?.map((e) => ClaimAddress.fromJson(e as Map<String, dynamic>))
          .toList(),
      claimStatus: (json['claimStatus'] as List<dynamic>?)
          ?.map((e) => ClaimStatus.fromJson(e as Map<String, dynamic>))
          .toList(),
      claimIndicators: (json['claimIndicators'] as List<dynamic>?)
          ?.map((e) => ClaimIndicator.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClaimDtoToJson(ClaimDto instance) => <String, dynamic>{
      'literalDescriptionMap': instance.literalDescriptionMap,
      'recordId': instance.recordId,
      'version': instance.version,
      'updated': instance.updated,
      'childUpdated': instance.childUpdated,
      'dtoUtilsSynchronized': instance.dtoUtilsSynchronized,
      'userIdCreated': instance.userIdCreated,
      'createdDateTime': instance.createdDateTime,
      'userIdUpdated': instance.userIdUpdated,
      'updatedDateTime': instance.updatedDateTime,
      'delInd': instance.delInd,
      'claimTypeCode': instance.claimTypeCode,
      'jurisdictionId': instance.jurisdictionId,
      'notificationPhoneTypeCode': instance.notificationPhoneTypeCode,
      'notificationPhoneNumber': instance.notificationPhoneNumber,
      'notificationSourceCode': instance.notificationSourceCode,
      'notificationMethodCode': instance.notificationMethodCode,
      'lossDateTimeZoneCode': instance.lossDateTimeZoneCode,
      'notificationDateTimeZoneCode': instance.notificationDateTimeZoneCode,
      'claimNumber': instance.claimNumber,
      'callerName': instance.callerName,
      'lossDescription': instance.lossDescription,
      'dateOfLossDate': instance.dateOfLossDate,
      'notificationDate': instance.notificationDate,
      'lossDateTime': instance.lossDateTime,
      'notificationTime': instance.notificationTime,
      'catManualFlag': instance.catManualFlag,
      'claimSourceCode': instance.claimSourceCode,
      'companyLobId': instance.companyLobId,
      'lobCode': instance.lobCode,
      'unverifiedPolicy': instance.unverifiedPolicy,
      'occurrenceDateVerifyIndicator': instance.occurrenceDateVerifyIndicator,
      'claimPolicyNumber': instance.claimPolicyNumber,
      'causeOfLossCode': instance.causeOfLossCode,
      'coverages': instance.coverages,
      'calClaimReportDate': instance.calClaimReportDate,
      'claimAliasNumbers': instance.claimAliasNumbers,
      'reinsuranceRetentionDetail': instance.reinsuranceRetentionDetail,
      'claimJurisdictionProfiles': instance.claimJurisdictionProfiles,
      'claimLossProfiles': instance.claimLossProfiles,
      'claimLossIndicatorProfiles': instance.claimLossIndicatorProfiles,
      'claimPolicyIndicatorProfiles': instance.claimPolicyIndicatorProfiles,
      'clmAddress': instance.clmAddress,
      'claimStatus': instance.claimStatus,
      'claimIndicators': instance.claimIndicators,
    };
