// coverage:ignore-file
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';

part 'claim_details.g.dart';

@JsonSerializable()
class ClaimDetails {
  ClaimDetails({
    this.claimId,
    this.claimNumber,
    this.isActiveCompanyLobCode,
    this.companyId,
    this.closeRecovery,
    this.modifyRecovery,
    this.claimBlocksCompositeDto,
    this.claimDto,
    this.claimPayments,
    this.claimAssignments,
  });

  factory ClaimDetails.fromJson(Map<String, dynamic> json) =>
      _$ClaimDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimDetailsToJson(this);

  @JsonKey(name: 'claimId')
  final String? claimId;
  @JsonKey(name: 'claimNumber')
  final String? claimNumber;
  @JsonKey(name: 'isActiveCompanyLobCode')
  final String? isActiveCompanyLobCode;
  @JsonKey(name: 'companyId')
  final String? companyId;
  @JsonKey(name: 'closeRecovery')
  final String? closeRecovery;
  @JsonKey(name: 'modifyRecovery')
  final String? modifyRecovery;
  @JsonKey(name: 'claimBlocksCompositeDto')
  final List<ClaimBlocksCompositeDto>? claimBlocksCompositeDto;
  @JsonKey(name: 'claimDto')
  final ClaimDto? claimDto;
  @JsonKey(name: 'claimPayments')
  final ClaimPayments? claimPayments;
  @JsonKey(name: 'claimAssignments')
  final ClaimAssignments? claimAssignments;

  ClaimDetails copyWith({
    String? claimId,
    String? claimNumber,
    String? isActiveCompanyLobCode,
    String? companyId,
    String? closeRecovery,
    String? modifyRecovery,
    List<ClaimBlocksCompositeDto>? claimBlocksCompositeDto,
    ClaimDto? claimDto,
    ClaimPayments? claimPayments,
    ClaimAssignments? claimAssignments,
  }) =>
      ClaimDetails(
        claimId: claimId ?? this.claimId,
        claimNumber: claimNumber ?? this.claimNumber,
        isActiveCompanyLobCode:
            isActiveCompanyLobCode ?? this.isActiveCompanyLobCode,
        companyId: companyId ?? this.companyId,
        closeRecovery: closeRecovery ?? this.closeRecovery,
        modifyRecovery: modifyRecovery ?? this.modifyRecovery,
        claimBlocksCompositeDto:
            claimBlocksCompositeDto ?? this.claimBlocksCompositeDto,
        claimDto: claimDto ?? this.claimDto,
        claimPayments: claimPayments ?? this.claimPayments,
        claimAssignments: claimAssignments ?? this.claimAssignments,
      );

  @override
  String toString() {
    return 'Claim ID: $claimId \n'
        'Claim Number: $claimNumber \n'
        'Is Active Company LOB Code: $isActiveCompanyLobCode \n'
        'Company ID: $companyId \n'
        'Close Recovery: $closeRecovery \n'
        'Modify Recovery: $modifyRecovery \n'
        'Claim Blocks Composite DTO: ${claimBlocksCompositeDto != null ? claimBlocksCompositeDto.toString() : "null"} \n'
        'Claim DTO: ${claimDto.toString()} \n'
        'Claim Payments: ${claimPayments.toString()} \n'
        'Claim Assignments: ${claimAssignments.toString()}';
  }
}
