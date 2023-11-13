// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';

part 'member_summary.g.dart';

@JsonSerializable()
class MemberSummary {
  MemberSummary({
    required this.policies,
  });

  // JSON conversion methods.
  factory MemberSummary.fromJson(Map<String, dynamic> json) =>
      _$MemberSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$MemberSummaryToJson(this);

  @JsonKey(name: 'Policies')
  final List<PolicySummary> policies;

  MemberSummary copy() {
    return MemberSummary(
      policies: List.from(policies),
    );
  }

  @override
  String toString() {
    String returnStr = '';
    returnStr += 'policies: $policies\n';
    return returnStr;
  }

  List<PolicySummary> get activePolicies => policies
      .where((element) => element.policyStatus == PolicyStatus.active.value)
      .toList();

  List<PolicySummary> get supportedPolicies => activePolicies
      .where(
        (element) =>
            element.policyType == PolicyType.homeowners ||
            element.policyType == PolicyType.txPersonalAuto ||
            element.policyType == PolicyType.agAdvantage,
      )
      .toList();

  // Returns a list PolicySelections for filing a claim
  List<PolicySelection?> policiesForClaims() => supportedPolicies
      .where(
        (e) =>
            e.policyType == PolicyType.txPersonalAuto ||
            e.policyType == PolicyType.homeowners,
      )
      .map((policy) => policy.toPolicySelection())
      .toList();

  List<PolicySummary> get personalAutoPolicies => activePolicies
      .where((element) => element.policyType == PolicyType.txPersonalAuto)
      .toList();
}
