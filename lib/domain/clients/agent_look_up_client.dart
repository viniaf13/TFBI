// coverage:ignore-file
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/data/network/clients/tfb_client.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';

part 'agent_look_up_client.g.dart';

@RestApi(baseUrl: kStageApiBaseUrl)
abstract class AgentLookUpClient extends TfbClient {
  factory AgentLookUpClient({required String baseUrl, required Dio dio}) {
    return _AgentLookUpClient(
      dio,
      baseUrl: baseUrl,
    );
  }

  // Returns the agency manager code by county code
  // County codes are in natural alphanumeric order and are numbered 1 - 254)
  @GET('$kAgentLookUpPath/$kCountyCode')
  Future<AgencyManagerCode?> getManagerCodeByCountyCode(
    @Path(kCountyCode) String kCountyCode,
  );

  // Returns the agency manager associated with the county name provided
  @GET('$kAgentLookUpPath/$kCountyName')
  Future<AgencyManager?> getManagerByCountyName(
    @Path(kCountyName) String kCountyName,
  );

  // Return Agent associated with this agent code
  @GET('$kAgentLookUpPath/$kAgentLookUpByCode')
  Future<AgentDetails?> getAgentDetailsByAgentCode(
    @Path(kAgentCode) String kAgentCode,
  );

  // Return Agent Code associated with this email
  @GET('$kAgentLookUpPath/$kAgentEmail')
  Future<AgentCode?> getAgentCodeByEmail(@Path(kAgentEmail) String kAgentEmail);

  // Return Agent Code associated with this member number
  @GET('$kAgentLookUpPath/$kAgentLookUpByMemberNum')
  Future<AgentCode?> getAgentCodeByMemberNumber(
    @Path(kMemberNumber) String kMemberNumber,
  );

  // Returns All Agents
  @GET('$kAgentLookUpPath/$kAgents')
  Future<List<Agent?>> getAgents();
}
