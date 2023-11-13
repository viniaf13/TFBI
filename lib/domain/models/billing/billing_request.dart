// coverage:ignore-file
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

part 'billing_request.g.dart';

@JsonSerializable()
class BillingRequest {
  BillingRequest({
    required this.policyNumber,
    required this.policyType,
    required this.policySubtype,
    required this.locationType,
  });

  factory BillingRequest.fromPolicySummary(PolicySummary policy) =>
      BillingRequest(
        policyNumber: policy.policyNumber,
        policyType: policy.policyType.value,
        policySubtype: policy.policySubType,
        locationType: 'BILLHIST',
      );

  // JSON conversion methods.
  factory BillingRequest.fromJson(Map<String, dynamic> json) =>
      _$BillingRequestFromJson(json);
  Map<String, dynamic> toJson() => _$BillingRequestToJson(this);

  @JsonKey(name: 'PolicyNumber')
  String policyNumber;
  @JsonKey(name: 'PolicyType')
  String policyType;
  @JsonKey(name: 'PolicySubType')
  String policySubtype;
  @JsonKey(name: 'LocationType')
  String locationType;
}
