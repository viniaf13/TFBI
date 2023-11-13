import 'package:json_annotation/json_annotation.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/member_summary.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';

part 'member_summary_response.g.dart';

@JsonSerializable()
class MemberSummaryResponse {
  MemberSummaryResponse({
    this.policies,
    this.errorMessage,
  });

  factory MemberSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$MemberSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MemberSummaryResponseToJson(this);

  @JsonKey(name: 'Policies')
  final List<PolicySummary>? policies;

  @JsonKey(name: 'ErrorMessage')
  final String? errorMessage;

  MemberSummary convertToMemberSummary() =>
      MemberSummary(policies: policies ?? []);

  @override
  String toString() {
    String returnStr = '';
    returnStr += 'policies: $policies\n';
    returnStr += 'errorMessage: $errorMessage\n';
    return returnStr;
  }
}
