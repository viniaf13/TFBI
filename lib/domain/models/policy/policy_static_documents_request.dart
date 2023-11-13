import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

part 'policy_static_documents_request.g.dart';

@JsonSerializable()
class PolicyStaticDocumentsRequest {
  PolicyStaticDocumentsRequest({
    required this.expirationDate,
    required this.policySymbol,
  });

  factory PolicyStaticDocumentsRequest.fromRequest(
    PolicySummary policy,
  ) =>
      PolicyStaticDocumentsRequest(
        policySymbol: policy.policySymbol,
        expirationDate: policy.policyExpirationDate,
      );

  // JSON conversion methods.
  factory PolicyStaticDocumentsRequest.fromJson(Map<String, dynamic> json) =>
      _$PolicyStaticDocumentsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PolicyStaticDocumentsRequestToJson(this);

  @JsonKey(name: 'PolicySymbol')
  String policySymbol;
  @JsonKey(name: 'ExpirationDate')
  String expirationDate;
}
