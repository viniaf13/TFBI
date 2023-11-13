import 'package:txfb_insurance_flutter/domain/clients/claims_client.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';

class TfbClaimsClientRepository {
  TfbClaimsClientRepository({
    required ClaimsClient client,
  }) : _client = client;

  final ClaimsClient _client;

  Future<ClaimsList> getAllMemberClaims(String memberNumber) async =>
      _client.getAllMemberNumberClaims(memberNumber);

  // Currently unused, for now; wrote before confirmation that we won't need
  Future<ClaimsList> getAllPolicyClaims(String policyNumber) async =>
      _client.getAllPolicyNumberClaims(policyNumber);

  Future<ClaimDetails?> getClaimDetails(
    String claimNumber,
    String policyNumber,
  ) async =>
      _client.getClaimDetails(claimNumber, policyNumber);
}
