// coverage:ignore-file
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';

part 'claim_current.g.dart';

@JsonSerializable()
class ClaimCurrent {
  ClaimCurrent({
    this.recordId,
    this.version,
    this.updated,
    this.childUpdated,
    this.dtoUtilsSynchronized,
    this.userIdCreated,
    this.createdDateTime,
    this.effectiveDateTime,
    this.actionCode,
    this.statusCode,
    this.stateCode,
    this.reasonCode,
    this.additionalReasons,
    this.expiredStatus,
    this.statusReserveFlag,
    this.statusWorkItemFlowFlag,
    this.statusCloseReserveFlag,
    this.literalDescriptionMap,
    this.userIdUpdated,
    this.updatedDateTime,
    this.endDateTime,
  });

  factory ClaimCurrent.fromJson(Map<String, dynamic> json) =>
      _$ClaimCurrentFromJson(json);
  Map<String, dynamic> toJson() => _$ClaimCurrentToJson(this);

  @JsonKey(name: 'recordId')
  final String? recordId;
  @JsonKey(name: 'version')
  final String? version;
  @JsonKey(name: 'updated')
  final String? updated;
  @JsonKey(name: 'childUpdated')
  final String? childUpdated;
  @JsonKey(name: 'dtoUtilsSynchronized')
  final String? dtoUtilsSynchronized;
  @JsonKey(name: 'userIdCreated')
  final String? userIdCreated;
  @JsonKey(name: 'createdDateTime')
  final String? createdDateTime;
  @JsonKey(name: 'effectiveDateTime')
  final String? effectiveDateTime;
  @JsonKey(name: 'actionCode')
  final String? actionCode;
  @JsonKey(name: 'statusCode')
  final String? statusCode;
  @JsonKey(name: 'stateCode')
  final String? stateCode;
  @JsonKey(name: 'reasonCode')
  final String? reasonCode;
  @JsonKey(name: 'additionalReasons')
  final String? additionalReasons;
  @JsonKey(name: 'expiredStatus')
  final String? expiredStatus;
  @JsonKey(name: 'statusReserveFlag')
  final String? statusReserveFlag;
  @JsonKey(name: 'statusWorkItemFlowFlag')
  final String? statusWorkItemFlowFlag;
  @JsonKey(name: 'statusCloseReserveFlag')
  final String? statusCloseReserveFlag;
  @JsonKey(name: 'literalDescriptionMap')
  final ClaimLiteralDescriptionMap? literalDescriptionMap;
  @JsonKey(name: 'userIdUpdated')
  final String? userIdUpdated;
  @JsonKey(name: 'updatedDateTime')
  final String? updatedDateTime;
  @JsonKey(name: 'endDateTime')
  final String? endDateTime;

  ClaimCurrent copyWith({
    String? recordId,
    String? version,
    String? updated,
    String? childUpdated,
    String? dtoUtilsSynchronized,
    String? userIdCreated,
    String? createdDateTime,
    String? effectiveDateTime,
    String? actionCode,
    String? statusCode,
    String? stateCode,
    String? reasonCode,
    String? additionalReasons,
    String? expiredStatus,
    String? statusReserveFlag,
    String? statusWorkItemFlowFlag,
    String? statusCloseReserveFlag,
    ClaimLiteralDescriptionMap? literalDescriptionMap,
    String? userIdUpdated,
    String? updatedDateTime,
    String? endDateTime,
  }) =>
      ClaimCurrent(
        recordId: recordId ?? this.recordId,
        version: version ?? this.version,
        updated: updated ?? this.updated,
        childUpdated: childUpdated ?? this.childUpdated,
        dtoUtilsSynchronized: dtoUtilsSynchronized ?? this.dtoUtilsSynchronized,
        userIdCreated: userIdCreated ?? this.userIdCreated,
        createdDateTime: createdDateTime ?? this.createdDateTime,
        effectiveDateTime: effectiveDateTime ?? this.effectiveDateTime,
        actionCode: actionCode ?? this.actionCode,
        statusCode: statusCode ?? this.statusCode,
        stateCode: stateCode ?? this.stateCode,
        reasonCode: reasonCode ?? this.reasonCode,
        additionalReasons: additionalReasons ?? this.additionalReasons,
        expiredStatus: expiredStatus ?? this.expiredStatus,
        statusReserveFlag: statusReserveFlag ?? this.statusReserveFlag,
        statusWorkItemFlowFlag:
            statusWorkItemFlowFlag ?? this.statusWorkItemFlowFlag,
        statusCloseReserveFlag:
            statusCloseReserveFlag ?? this.statusCloseReserveFlag,
        literalDescriptionMap:
            literalDescriptionMap ?? this.literalDescriptionMap,
        userIdUpdated: userIdUpdated ?? this.userIdUpdated,
        updatedDateTime: updatedDateTime ?? this.updatedDateTime,
        endDateTime: endDateTime ?? this.endDateTime,
      );
}
