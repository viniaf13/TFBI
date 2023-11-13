// coverage:ignore-file
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/data/network/clients/tfb_client.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';

part 'claims_client.g.dart';

@RestApi(baseUrl: kStageApiBaseUrl)
abstract class ClaimsClient extends TfbClient {
  factory ClaimsClient({
    required String baseUrl,
    required Dio dio,
  }) =>
      _ClaimsClient(
        dio,
        baseUrl: baseUrl,
      );

  @GET('$kClaimsLookUpPath/$kAllMemberClaims')
  Future<ClaimsList> getAllMemberNumberClaims(
    @Path(kClaimsMemberNumber) String kClaimsMemberNumber,
  );

  @GET('$kClaimsLookUpPath/$kAllPolicyClaims')
  Future<ClaimsList> getAllPolicyNumberClaims(
    @Path(kClaimsPolicyNumber) String kClaimsPolicyNumber,
  );

  @GET('$kClaimsLookUpPath/$kClaimsDetail')
  Future<ClaimDetails> getClaimDetails(
    @Path(kClaimsClaimNumber) String kClaimsClaimNumber,
    @Path(kClaimsPolicyNumber) String kClaimsPolicyNumber,
  );
}
