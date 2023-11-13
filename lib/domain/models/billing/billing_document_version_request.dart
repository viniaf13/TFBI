import 'package:json_annotation/json_annotation.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';

part 'billing_document_version_request.g.dart';

@JsonSerializable()
class BillingDocumentVersionRequest {
  BillingDocumentVersionRequest({
    required this.policyNumber,
    required this.policyType,
    required this.policySubType,
    required this.versionId,
    required this.descriptionTerm,
  });

  factory BillingDocumentVersionRequest.fromJson(Map<String, dynamic> json) =>
      _$BillingDocumentVersionRequestFromJson(json);

  factory BillingDocumentVersionRequest.fromPolicyVersionAndDescription(
    String versionId,
    PolicySummary policy,
    String descriptionTerm,
  ) =>
      BillingDocumentVersionRequest(
        policyNumber: policy.policyNumber,
        policyType: policy.policyType.value,
        policySubType: int.parse(policy.policySubType),
        versionId: versionId,
        descriptionTerm: descriptionTerm,
      );

  Map<String, dynamic> toJson() => _$BillingDocumentVersionRequestToJson(this);

  @JsonKey(name: 'PolicyNumber')
  final String policyNumber;
  @JsonKey(name: 'PolicyType')
  final String policyType;
  @JsonKey(name: 'PolicySubType')
  final int policySubType;
  @JsonKey(name: 'VersionId')
  final String versionId;
  @JsonKey(name: 'DescriptionTerm')
  final String descriptionTerm;
}
