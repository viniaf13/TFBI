// coverage:ignore-file
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/shared/enum/claim_status_enum.dart';

part 'claim.g.dart';

@JsonSerializable()
class Claim {
  Claim({
    this.claimNumber,
    this.claimStatus,
    this.policyNumber,
    this.policyType,
    this.dateOfLoss,
  });

  factory Claim.fromJson(Map<String, dynamic> json) => _$ClaimFromJson(json);
  Map<String, dynamic> toJson() => _$ClaimToJson(this);

  @JsonKey(name: 'ClaimNumber')
  final String? claimNumber;
  @JsonKey(
    name: 'ClaimStatus',
    unknownEnumValue: ClaimStatusEnum.undefinedClaimStatus,
  )
  final ClaimStatusEnum? claimStatus;
  @JsonKey(name: 'PolicyNumber')
  final String? policyNumber;
  @JsonKey(name: 'PolicyType', unknownEnumValue: PolicyType.unsupportedPolicy)
  final PolicyType? policyType;
  @JsonKey(name: 'DateOfLoss')
  final String? dateOfLoss;

  Claim copyWith({
    String? claimNumber,
    ClaimStatusEnum? claimStatus,
    String? policyNumber,
    PolicyType? policyType,
    String? dateOfLoss,
  }) =>
      Claim(
        claimNumber: claimNumber ?? this.claimNumber,
        claimStatus: claimStatus ?? this.claimStatus,
        policyNumber: policyNumber ?? this.policyNumber,
        policyType: policyType ?? this.policyType,
        dateOfLoss: dateOfLoss ?? this.dateOfLoss,
      );

  @override
  String toString() {
    return 'Claim Number: $claimNumber \n'
        'Claim Status: $claimStatus \n'
        'Policy Number: $policyNumber \n'
        'Policy Type: $policyType \n'
        'Date Of Loss: $dateOfLoss';
  }
}
