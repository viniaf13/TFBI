// coverage:ignore-file
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

part 'policy_document_request.g.dart';

@JsonSerializable()
class PolicyDocumentRequest {
  PolicyDocumentRequest({
    required this.policyNumber,
    required this.policyType,
    required this.policySubtype,
    required this.documentId,
  });

  factory PolicyDocumentRequest.fromPolicySummary(
    PolicySummary policy,
    String documentId,
  ) =>
      PolicyDocumentRequest(
        policyNumber: policy.policyNumber,
        policyType: policy.policyType,
        policySubtype: policy.policySubType,
        documentId: documentId,
      );

  factory PolicyDocumentRequest.fromJson(Map<String, dynamic> json) =>
      _$PolicyDocumentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PolicyDocumentRequestToJson(this);

  @JsonKey(name: 'PolicyNumber')
  String policyNumber;
  @JsonKey(name: 'PolicyType')
  PolicyType policyType;
  @JsonKey(name: 'PolicySubType')
  String policySubtype;
  @JsonKey(name: 'DocumentId')
  String documentId;
}
