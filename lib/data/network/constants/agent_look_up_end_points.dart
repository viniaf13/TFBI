import 'dart:core';

/// kBaseUrl + "Service Base Url" + "Agent End Point"
/// Example:
/// https://web.txfb-ins.com/services/TFBIC.Services.RESTAgent.Lookup/REST_AgentLookup.svc/Agent/Code/28873

/// Services Base URLs
const String kAgentLookUpPath =
    'services/TFBIC.Services.RESTAgent.Lookup/REST_AgentLookup.svc';
const String kCountyLookUpPath =
    'services/TFBIC.Services.RESTCounty.Lookup/REST_CountyLookup.svc';

/// Agent End Points
// Returns a list of all agents
const String kAgents = 'Agents';
// Return agent by agent code
const String kAgentLookUpByCode = 'Agent/Code/{$kAgentCode}';
// Return agent by email
const String kAgentLookUpByEmail = 'Agent/Email/{$kAgentEmail}';
// Returns the agent code associated with the given member number
const String kAgentLookUpByMemberNum = 'Agent/MemberNumber/{$kMemberNumber}';
// Returns the agency manager code by county code
const String kAgencyManagerCodeByCounty =
    'AgencyManager/County/Code/{$kCountyCode}';
// Return the agency manager by county name
const String kAgencyManagerCountyName =
    'AgencyManager/County/Name/{$kCountyName}';
// @Post
const String kAgentRegistration = 'AgentRegistration';
// Returns a list of agents associated with the zip code
const String kAgentsByZip = 'Agents/Zipcode/{$kZipCode}';
// Returns a list of all agents in a given county
const String kAgentsByCounty = 'AgentsByCounty';
// Returns agent information for a given agent code
const String kAgentWLatLong = 'AgentWLatLong/Code/{$kAgentCode}';
// Returns the District Manager for a given county
const String kDistrictSalesManagerByCounty = 'DSM/County/{$kCounty}';

/// @Path Constants
const String kAgentCode = 'AGENTCODE';
const String kAgentEmail = 'AGENTEMAIL';
const String kMemberNumber = 'MEMBERNUMBER';
const String kCountyCode = 'COUNTYCODE';
const String kCountyName = 'COUNTYNAME';
const String kZipCode = 'ZIPCODE';
const String kCounty = 'COUNTY';
