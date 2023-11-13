// coverage:ignore-file
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';

part 'claim_status.g.dart';

@JsonSerializable()
class ClaimStatus {
  ClaimStatus({
    this.applicableActions,
    this.statusReasonsMap,
    this.statusAdditionalReasonsMap,
    this.actionStatusCodeMap,
    this.statusCompleteWorkItemFlag,
    this.statusInCompleteWorkItemFlag,
    this.statusTurnaroundDocumentsFlag,
    this.statusCloseReserveFlag,
    this.current,
    this.expired,
  });

  factory ClaimStatus.fromJson(Map<String, dynamic> json) =>
      _$ClaimStatusFromJson(json);
  Map<String, dynamic> toJson() => _$ClaimStatusToJson(this);

  @JsonKey(name: 'applicableActions')
  final String? applicableActions;
  @JsonKey(name: 'statusReasonsMap')
  final String? statusReasonsMap;
  @JsonKey(name: 'statusAdditionalReasonsMap')
  final String? statusAdditionalReasonsMap;
  @JsonKey(name: 'actionStatusCodeMap')
  final String? actionStatusCodeMap;
  @JsonKey(name: 'statusCompleteWorkItemFlag')
  final String? statusCompleteWorkItemFlag;
  @JsonKey(name: 'statusInCompleteWorkItemFlag')
  final String? statusInCompleteWorkItemFlag;
  @JsonKey(name: 'statusTurnaroundDocumentsFlag')
  final String? statusTurnaroundDocumentsFlag;
  @JsonKey(name: 'statusCloseReserveFlag')
  final String? statusCloseReserveFlag;
  @JsonKey(name: 'current')
  final List<ClaimCurrent>? current;
  @JsonKey(name: 'expired')
  final List<ClaimCurrent>? expired;

  ClaimStatus copyWith({
    String? applicableActions,
    String? statusReasonsMap,
    String? statusAdditionalReasonsMap,
    String? actionStatusCodeMap,
    String? statusCompleteWorkItemFlag,
    String? statusInCompleteWorkItemFlag,
    String? statusTurnaroundDocumentsFlag,
    String? statusCloseReserveFlag,
    List<ClaimCurrent>? current,
    List<ClaimCurrent>? expired,
  }) =>
      ClaimStatus(
        applicableActions: applicableActions ?? this.applicableActions,
        statusReasonsMap: statusReasonsMap ?? this.statusReasonsMap,
        statusAdditionalReasonsMap:
            statusAdditionalReasonsMap ?? this.statusAdditionalReasonsMap,
        actionStatusCodeMap: actionStatusCodeMap ?? this.actionStatusCodeMap,
        statusCompleteWorkItemFlag:
            statusCompleteWorkItemFlag ?? this.statusCompleteWorkItemFlag,
        statusInCompleteWorkItemFlag:
            statusInCompleteWorkItemFlag ?? this.statusInCompleteWorkItemFlag,
        statusTurnaroundDocumentsFlag:
            statusTurnaroundDocumentsFlag ?? this.statusTurnaroundDocumentsFlag,
        statusCloseReserveFlag:
            statusCloseReserveFlag ?? this.statusCloseReserveFlag,
        current: current ?? this.current,
        expired: expired ?? this.expired,
      );
}
