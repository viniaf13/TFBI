/// kBaseUrl + kMemberAccessPath + End Point
/// Example:
/// https://web.txfb-ins.com/services/TFBIC.Services.RESTAgent.Lookup/REST_AgentLookup.svc/Agent/Code/28873
library;

const String kMemberAccessPath =
    'services/TFBIC.Services.RESTMember.Access/REST_MemberAccess.svc';

/// Member Access @GET End Points
const String kFetchLogin = '$kMemberAccessPath/fetch-login/{memberNumber}';
const String kUpdateMultiEmailVerification =
    'UpdateMultipleEmailVerification/{$kValidationCode}';
const String kForgotPasswordVerify = '/ForgotPassword/Verify';
const String kUpdateMemberSecurePassword = '/UpdateMemberSecurePassword';
const String kForgotPasswordEndpoint =
    '$kMemberAccessPath/ForgotPassword/{email}';
const String kMobileVersion = 'mobile/version';

/// Member Access @POST End Points
const String kSecureRegistration = 'SecureRegistration';
const String kRegisterResentEndpoint = '$kMemberAccessPath/registration/resend';
const String kDeleteAccountEndpoint = '$kMemberAccessPath/account/archive';
const String kUpdateEmailEndpoint =
    '$kMemberAccessPath/SendMultipleEmailVerification';

/// End Point Path Constants
const String kValidationCode = 'validationCode';
