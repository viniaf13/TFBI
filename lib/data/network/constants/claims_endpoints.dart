/// Claims Base Url
const String kClaimsLookUpPath =
    'services/TFBIC.Services.RESTClaims.Lookup/Claims';

/// FNOL -- File A Claim Path
const String kFileAClaimAddPath = 'services/TFBIC.Services.RESTClaims.Add';
const String kFileAClaimPath = 'services/TFBIC.Services.RESTClaims.Lookup';

/// Claims End Points
/// Returns the details of a specific claim
const String kClaimsDetail =
    'detail/{$kClaimsClaimNumber}/{$kClaimsPolicyNumber}';

/// Returns all claims for this member
const String kAllMemberClaims = 'member/{$kClaimsMemberNumber}';

/// Returns all claims for this policy
const String kAllPolicyClaims = 'policy/{$kClaimsPolicyNumber}';

/// FNOL -- File a claim endpoints
const String kFileAutoClaim = 'fnol/auto';
const String kFilePropertyClaim = 'fnol/property';
const String kSubmitClaimCounties = 'lookup/counties';
const String kSubmitClaimPhones = 'lookup/phone-types';
const String kSubmitClaimReporters = 'lookup/reporter-types';
const String kSubmitClaimLossTypes = 'lookup/loss-types';
const String kVehicleYears = 'lookup/vehicle-years';
const String kVehicleMakes = 'lookup/vehicle-makes/{$kVehicleYear}';
const String kVehicleModels = '/lookup/vehicle-models';
const String kPolicyDetails =
    '/policy/{$kPolicyNumber}/{$kPolicySymbol}/{$kClaimDate}';

/// Claim Path Constants
const String kClaimsClaimNumber = 'CLAIMS_NUMBER';
const String kClaimsPolicyNumber = 'CLAIMS_POLICY_NUMBER';
const String kClaimsMemberNumber = 'CLAIMS_MEMBER_NUMBER';
const String kVehicleYear = 'VEHICLE_YEAR';
const int kClaimType = -1;
const String kPolicyNumber = 'POLICY_NUMBER';
const String kPolicySymbol = 'POLICY_SYMBOL';
const String kClaimDate = 'CLAIM_DATE';
const String kClaimId = 'CLAIM_ID';

/// File a Claim Photo Path Constants
const String kSubmitAutoPhoto = 'fnol/photos/add/{$kClaimId}';
const String kSubmitPropertyPhoto = 'photos/add/{$kClaimId}';
