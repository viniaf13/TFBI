// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimStatus _$ClaimStatusFromJson(Map<String, dynamic> json) => ClaimStatus(
      applicableActions: json['applicableActions'] as String?,
      statusReasonsMap: json['statusReasonsMap'] as String?,
      statusAdditionalReasonsMap: json['statusAdditionalReasonsMap'] as String?,
      actionStatusCodeMap: json['actionStatusCodeMap'] as String?,
      statusCompleteWorkItemFlag: json['statusCompleteWorkItemFlag'] as String?,
      statusInCompleteWorkItemFlag:
          json['statusInCompleteWorkItemFlag'] as String?,
      statusTurnaroundDocumentsFlag:
          json['statusTurnaroundDocumentsFlag'] as String?,
      statusCloseReserveFlag: json['statusCloseReserveFlag'] as String?,
      current: (json['current'] as List<dynamic>?)
          ?.map((e) => ClaimCurrent.fromJson(e as Map<String, dynamic>))
          .toList(),
      expired: (json['expired'] as List<dynamic>?)
          ?.map((e) => ClaimCurrent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClaimStatusToJson(ClaimStatus instance) =>
    <String, dynamic>{
      'applicableActions': instance.applicableActions,
      'statusReasonsMap': instance.statusReasonsMap,
      'statusAdditionalReasonsMap': instance.statusAdditionalReasonsMap,
      'actionStatusCodeMap': instance.actionStatusCodeMap,
      'statusCompleteWorkItemFlag': instance.statusCompleteWorkItemFlag,
      'statusInCompleteWorkItemFlag': instance.statusInCompleteWorkItemFlag,
      'statusTurnaroundDocumentsFlag': instance.statusTurnaroundDocumentsFlag,
      'statusCloseReserveFlag': instance.statusCloseReserveFlag,
      'current': instance.current,
      'expired': instance.expired,
    };
