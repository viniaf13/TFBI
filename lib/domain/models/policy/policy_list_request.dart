// coverage:ignore-file
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

part 'policy_list_request.g.dart';

@JsonSerializable()
class PolicyListRequest {
  PolicyListRequest({
    required this.policyNumber,
    required this.policyType,
    required this.policySubtype,
    this.locationType = 'POL-HIST', // Location type for Personal Auto Policy
  });

  factory PolicyListRequest.fromPolicySummary(PolicySummary policy) =>
      PolicyListRequest(
        policyNumber: policy.policyNumber,
        policyType: policy.policyType,
        policySubtype: policy.policySubType,
      );

  // JSON conversion methods.
  factory PolicyListRequest.fromJson(Map<String, dynamic> json) =>
      _$PolicyListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PolicyListRequestToJson(this);

  @JsonKey(name: 'PolicyNumber')
  String policyNumber;
  @JsonKey(name: 'PolicyType')
  PolicyType policyType;
  @JsonKey(name: 'PolicySubType')
  String policySubtype;
  @JsonKey(name: 'LocationType')
  String? locationType = 'POL-HIST';
}
