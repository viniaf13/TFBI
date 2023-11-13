// coverage:ignore-file
import 'package:txfb_insurance_flutter/data/network/clients/tfb_client.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/autopay_submission_request.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/paperless/ebill_lookup_request.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/paperless/ebill_lookup_response.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/paperless/paperless_lookup_request.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/paperless/paperless_lookup_response.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/member_summary_response.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

part 'policy_lookup_client.g.dart';

const kGetMemberSummaryEndpoint =
    '/services/TFBIC.Services.RESTPolicy.Lookup/account/summary';
const kHomeownersPolicyEndpoint =
    '/services/TFBIC.Services.RESTHOL.Lookup/policyholder';
const kPersonalAutoPolicyEndpoint =
    '/services/TFBIC.Services.RESTPA6.Lookup/policyholder';
const kPaperlessLookupEndpoint =
    '/services/TFBIC.Services.RESTPolicy.Lookup/paperless/lookup';
const kEbillLookUpEndpoint =
    '/services/TFBIC.Services.RESTPayments.Lookup/ebill/lookup';
const kRoutingNumberEndpoint =
    '/services/TFBIC.Services.RESTPayments.Lookup/validation/routing-number';
const kAutopayEnrollmentEndpoint =
    '/services/TFBIC.Services.RESTPayments.Modify/eft';
const kAgAdvantagePolicyEndpoint =
    '/services/TFBIC.Services.RESTTexasAg.Lookup/REST_TexasAgLookup.svc/PolicyHolder';

@RestApi(baseUrl: kStageApiBaseUrl)
abstract class TfbPolicyLookupClient extends TfbClient {
  factory TfbPolicyLookupClient({
    required String baseUrl,
    required Dio dio,
  }) {
    return _TfbPolicyLookupClient(
      dio,
      baseUrl: baseUrl,
    );
  }

  @GET(kGetMemberSummaryEndpoint)
  Future<MemberSummaryResponse> getMemberSummary(
    // TODO: See if we can pass this as a header or in the body instead
    @Query('access_token') String accessToken,
  );

  @GET('$kHomeownersPolicyEndpoint/{policyNum}/{policyType}/{policySubtype}')
  Future<HomeownerPolicyDetail> getHomeownersPolicy(
    @Path('policyNum') String policyNum,
    @Path('policyType') String policyType,
    @Path('policySubtype') String policySubtype,
    @Query('access_token') String accessToken,
  );

  @GET('$kPersonalAutoPolicyEndpoint/{policyNum}')
  Future<AutoPolicyDetail> getPersonalAutoPolicy(
    @Path('policyNum') String policyNum,
    @Query('access_token') String accessToken,
  );

  @GET(kAgAdvantagePolicyEndpoint)
  Future<AgAdvantagePolicyDetail> getAgAdvantagePolicy(
    @Query('PolicyNumber') String policyNum,
    @Query('PolicyType') String policyType,
    @Query('PolicySubType') String policySubtype,
  );

  @POST(kEbillLookUpEndpoint)
  Future<EbillLookupResponse> fetchEbillNotificationDetails(
    @Body() EbillLookupRequest request,
  );

  @POST(kPaperlessLookupEndpoint)
  Future<PaperlessLookupResponse> fetchPaperlessAccountDetails(
    @Body() PaperlessLookupRequest request,
  );

  @GET('$kRoutingNumberEndpoint/{routingNumber}')
  Future<String?> validateRoutingNumber(
    @Path('routingNumber') String routingNumber,
  );

  @POST(kAutopayEnrollmentEndpoint)
  Future<bool> autopayEnrollment(
    @Body() AutopaySubmissionRequest request,
  );
}
