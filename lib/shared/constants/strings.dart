/// To create a localized string, first provide all translations in the localization
/// .arb files (resources/l10n) then build the project to generate references.
/// Add the fallback string to the strings.dart file (app/utils/strings.dart).
/// Add the override getter with the fail safe string to Localizations for
/// the localized string (data/localizations/app_localizations.dart)
library;

// Global UI Strings
const String kSuccess = 'success';
const String kFailure = 'failure';
const String kEmptyString = '';

// Logger Names
const String kHandlingResponseCodesLogger = 'Handling Response Codes';
const String kCompareDigit = 'compareDigit';

// Plugin
const String kPluginHaven = 'plugin_haven';
const String kGetPlatVersion = 'getPlatformVersion';

// Biometrics (TFBI-74)
const String kAuthenticate = 'authenticate';
const String kTfbUser = 'tfb_user';
const String kUsername = 'username';
const String kPassword = 'password';
const String kDeviceSupported = 'device_supported';
const String kBioEnabled = 'biometrics_enabled';
const String kInvalidTokenFormat = 'Invalid token format';
const String kPayloadExp = 'exp';
const String kSplitAtPeriod = '.';
const String kLocalAuthFailed = 'Local Authentication Failure';
const String kUserAuthenticated = 'User is locally authenticated';
const String kUserAuthFailed = 'Local authentication for this user has failed';
const String kUserObjStored = 'User Stored Into Storage';
const String kUserStorageFailed = 'User was not properly stored';
const String kValidToken = 'User has a valid access token';
const String kExpiredToken = 'Access Token is expired or does not exist';

/// For Biometrics Testing ///
const String kBioCheck = 'bioCheck';
const String kDeviceSupport = 'deviceSupport';
const String kAuthenticateUser = 'authenticateUser';

const String kBiometricsReason = 'Sign In Using Your Fingerprint Sensor';
const String kForceManual =
    'Session has expired. Please sign in again to enable biometrics.';
const String kUserUnsaved =
    'Something went wrong! Unable to properly store user.';
const String kUserUnavailable =
    'No user currently stored. Please log in, again.';
const String kDeviceUnsupported =
    'Device biometrics are currently unsupported. If biometrics are available on your device, ensure they have been set up.';
const String kCredentialsFailure =
    'There seems to be a problem with your username and/or password. Please check that your credentials are correct and try again.';
const String kUnknownFailure = 'Uh Oh! Something went wrong. Please try again.';

// Prefs
const String kSettings = 'settings';
const String kHiveInitException = 'Hive Init exception:';
const String kIsFirstRun = 'isFirstRun';

// Strings for Environment Swapping
const String kSwitchProd = 'Switch to prod';
const String kSwitchStage = 'Switch to stage';
const String kSwitchDev = 'Switch to dev';
const String kSwitchQa = 'Switch to qa';

const String kUserDatabaseBoxName = 'user_database_box';
const String kUserDatabaseKey = 'user';

const String kDevBoxName = 'dev_box';
const String kStageBoxName = 'stage_box';
const String kProductionBoxName = 'production_box';

const String kClaimsOpen = 'OPEN';
const String kDateFormat = 'yyyy-MM-ddTHH:mm:ss';
const String kAlternateDateFormat = 'yyyy-MM-dd HH:mm:ss';
const String kUiDateFormat = 'M/dd/yyyy';
const String kInvalidDateFormat = 'Invalid date format:';
const String kUnknownDateFormat = 'Unknown Date of Loss';

const String alreadyLoggedInKey = 'alreadyLoggedIn';
const String kUrlWebsiteTxfb = 'https://txfb-ins.com';

// Strings for google wallet config
const String kGoogleWalletTitleKey = 'cardTitle/defaultValue/value';
const String kGoogleWalletBackgroundColorKey = 'hexBackgroundColor';
const String kGoogleWalletSubheaderKey = 'subheader/defaultValue/value';
const String kGoogleWalletHeaderKey = 'header/defaultValue/value';
const String kGoogleWalletField0HeaderKey = 'textModulesData/0/header';
const String kGoogleWalletField1HeaderKey = 'textModulesData/1/header';
const String kGoogleWalletField2HeaderKey = 'textModulesData/2/header';
const String kGoogleWalletField3HeaderKey = 'textModulesData/3/header';
const String kGoogleWalletField0BodyKey = 'textModulesData/0/body';
const String kGoogleWalletField1BodyKey = 'textModulesData/1/body';
const String kGoogleWalletField2BodyKey = 'textModulesData/2/body';
const String kGoogleWalletField3BodyKey = 'textModulesData/3/body';

const String kGoogleWalletTitleValue = 'TFBI Auto Insurance Card';
const String kGoogleWalletBackgroundColorValue = '#ffffff';
const String kGoogleWalletSubheaderValue = 'Policy Owner';
const String kGoogleWalletHeaderKeyValue = '';
const String kGoogleWalletField0HeaderValue = 'NOT PROOF OF COVERAGE';
const String kGoogleWalletField0BodyValue = 'View Official ID Card in App';
const String kGoogleWalletField1HeaderValue = 'VALID THRU';
const String kGoogleWalletField1BodyValue = '';
const String kGoogleWalletField2HeaderValue = 'POLICY NUMBER';
const String kGoogleWalletField2BodyValue = '';
const String kGoogleWalletField3HeaderValue = 'VEHICLE';
const String kGoogleWalletField3BodyValue = '';

// Strings for apple wallet config
const String kAppleWalletOrganizationNameKey = 'organizationName';
const String kAppleWalletDescriptionKey = 'description';
const String kAppleWalletLogoTextKey = 'logoText';
const String kAppleWalletForegroundColorKey = 'foregroundColor';
const String kAppleWalletBackgroundColorKey = 'backgroundColor';
const String kAppleWalletPrimaryFieldKey = 'generic/primaryFields/0/value';
const String kAppleWalletSecondaryField0LabelKey =
    'generic/secondaryFields/0/label';
const String kAppleWalletSecondaryField0BodyKey =
    'generic/secondaryFields/0/value';
const String kAppleWalletSecondaryField1LabelKey =
    'generic/secondaryFields/1/label';
const String kAppleWalletSecondaryField1BodyKey =
    'generic/secondaryFields/1/value';
const String kAppleWalletAuxiliaryField0LabelKey =
    'generic/auxiliaryFields/0/label';
const String kAppleWalletAuxiliaryField0BodyKey =
    'generic/auxiliaryFields/0/value';
const String kAppleWalletAuxiliaryField1LabelKey =
    'generic/auxiliaryFields/1/label';
const String kAppleWalletAuxiliaryField1BodyKey =
    'generic/auxiliaryFields/1/value';

const String kAppleWalletOrganizationNameValue = 'TFBI';
const String kAppleWalletDescriptionValue = 'Texas Farm Bureau Insurance';
const String kAppleWalletLogoTextValue = 'TFBI Auto Insurance Card';
const String kAppleWalletForegroundColorValue = 'rgb(0, 45, 90)';
const String kAppleWalletBackgroundColorValue = 'rgb(255, 255, 255)';
const String kAppleWalletPrimaryFieldValue = '';
const String kAppleWalletSecondaryField0LabelValue = 'NOT PROOF OF COVERAGE';
const String kAppleWalletSecondaryField0BodyValue =
    'View Official ID Card in App';
const String kAppleWalletSecondaryField1LabelValue = 'VALID THRU';
const String kAppleWalletSecondaryField1BodyValue = '';
const String kAppleWalletAuxiliaryField0LabelValue = 'POLICY NUMBER';
const String kAppleWalletAuxiliaryField0BodyValue = '';
const String kAppleWalletAuxiliaryField1LabelValue = 'VEHICLE';
const String kAppleWalletAuxiliaryField1BodyValue = '';

// Roadside Assistance
const String kRequestAssistancePhoneDisplay = '1.833.TFB.ROAD';
const String kRequestAssistancePhoneDialing = '1-833-832-7623';
const String kRequestAssistanceServiceOnline = 'https://tfb.rsahelp.com';

// Customer Service display
const String kCutomerServicePhoneNumber = '1.800.772.6535';
const String kFraudHotlinePhoneNumber = '1.800.711.0394';
const String kHourClaimsReportingCenterPhoneNumber = '1.800.266.5458';
const String kRoadsideAssistancePhoneNumber = '1.800.832.7623';
const String kPayByPhonePhoneNumber = '1.800.658.9038';
const String kGeneralCustomerServiceEmail = 'webmaster@txfb-ins.com';

// Customer service dialing
const String kHourClaimsReportingCenterPhoneNumberForDialing = '800-266-5458';

// Office locator URLs
const String kOfficeLocatorAppleMaps =
    'https://maps.apple.com/?q=Texas_farm_bureau_insurance';
const String kOfficeLocatorGoogleMaps =
    'https://www.google.com/maps/search/?api=1&query=Texas_farm_bureau_insurance';

// Photo submission workmanager
const String kTfbUserToken = 'tfb_user_token';
const String kApiBaseUrl = 'api_base_url';
