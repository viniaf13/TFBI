// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_current.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimCurrent _$ClaimCurrentFromJson(Map<String, dynamic> json) => ClaimCurrent(
      recordId: json['recordId'] as String?,
      version: json['version'] as String?,
      updated: json['updated'] as String?,
      childUpdated: json['childUpdated'] as String?,
      dtoUtilsSynchronized: json['dtoUtilsSynchronized'] as String?,
      userIdCreated: json['userIdCreated'] as String?,
      createdDateTime: json['createdDateTime'] as String?,
      effectiveDateTime: json['effectiveDateTime'] as String?,
      actionCode: json['actionCode'] as String?,
      statusCode: json['statusCode'] as String?,
      stateCode: json['stateCode'] as String?,
      reasonCode: json['reasonCode'] as String?,
      additionalReasons: json['additionalReasons'] as String?,
      expiredStatus: json['expiredStatus'] as String?,
      statusReserveFlag: json['statusReserveFlag'] as String?,
      statusWorkItemFlowFlag: json['statusWorkItemFlowFlag'] as String?,
      statusCloseReserveFlag: json['statusCloseReserveFlag'] as String?,
      literalDescriptionMap: json['literalDescriptionMap'] == null
          ? null
          : ClaimLiteralDescriptionMap.fromJson(
              json['literalDescriptionMap'] as Map<String, dynamic>),
      userIdUpdated: json['userIdUpdated'] as String?,
      updatedDateTime: json['updatedDateTime'] as String?,
      endDateTime: json['endDateTime'] as String?,
    );

Map<String, dynamic> _$ClaimCurrentToJson(ClaimCurrent instance) =>
    <String, dynamic>{
      'recordId': instance.recordId,
      'version': instance.version,
      'updated': instance.updated,
      'childUpdated': instance.childUpdated,
      'dtoUtilsSynchronized': instance.dtoUtilsSynchronized,
      'userIdCreated': instance.userIdCreated,
      'createdDateTime': instance.createdDateTime,
      'effectiveDateTime': instance.effectiveDateTime,
      'actionCode': instance.actionCode,
      'statusCode': instance.statusCode,
      'stateCode': instance.stateCode,
      'reasonCode': instance.reasonCode,
      'additionalReasons': instance.additionalReasons,
      'expiredStatus': instance.expiredStatus,
      'statusReserveFlag': instance.statusReserveFlag,
      'statusWorkItemFlowFlag': instance.statusWorkItemFlowFlag,
      'statusCloseReserveFlag': instance.statusCloseReserveFlag,
      'literalDescriptionMap': instance.literalDescriptionMap,
      'userIdUpdated': instance.userIdUpdated,
      'updatedDateTime': instance.updatedDateTime,
      'endDateTime': instance.endDateTime,
    };
