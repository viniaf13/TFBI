// coverage:ignore-file
import 'package:txfb_insurance_flutter/domain/models/claims/claim_details/claim_details.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/shared/enum/claim_status_enum.dart';

class FullClaim {
  FullClaim({
    required this.claimNumber,
    required this.statusEnum,
    required this.policyNumber,
    required this.policyType,
    required this.dateOfLoss,
    required this.claimDetails,
  });

  late String? claimNumber;
  late ClaimStatusEnum? statusEnum;
  late String? policyNumber;
  late PolicyType? policyType;
  late String? dateOfLoss;
  late ClaimDetails? claimDetails;

  bool isActive() => statusEnum == ClaimStatusEnum.active;
  bool isAuto() => policyType == PolicyType.txPersonalAuto;

  @override
  String toString() {
    return 'Claim:\n'
        'ClaimNumber: $claimNumber\n'
        'StatusEnum: ${statusEnum?.value ?? ''}\n'
        'PolicyNumber: $policyNumber\n'
        'PolicyType: $policyType\n'
        'Date Of Loss: $dateOfLoss\n'
        'Details:\n'
        '${claimDetails.toString()}';
  }
}
