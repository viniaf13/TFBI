import 'package:plugin_haven/plugin_haven.dart';

const String kProductionApiBaseUrl = 'https://web.txfb-ins.com/';
const String kStageApiBaseUrl = 'https://webstg.txfb-ins.com/';
const String kQaApiBaseUrl = 'https://webqa.txfb-ins.com/';

const String kProductionUrlWebsiteTxfb = 'https://txfb-ins.com';
const String kStageUrlWebsiteTxfb = 'https://wwwstg.txfb-ins.com';
const String kQAUrlWebsiteTxfb = 'https://wwwstg.txfb-ins.com';

const String kProductionMemberShip = 'https://utilities.txfb.com/membership';
const String kTestMemberShip = 'https://utilities.txfb.com/membershiptest';

//TODO: These url values will need to be updated once TFBI's wallet service is created
const String kAppleWalletUrl = 'http://localhost:8000';
const String kGoogleWalletUrl = 'http://10.0.2.2:8000';

const String kWalletCertAuthIosUrl = 'http://localhost:8000';
const String kWalletCertAuthAndroidUrl = 'http://10.0.2.2:8000';

const int kBaseTimeoutValue = 3000;

const String kClientError = 'Client Error';
const String kServerError =
    'A network error as occurred. Please try again later';
const String kRequestApiError =
    'We are having an issue loading your information. We apologize for this inconvenience, please try again later.';
const String kGeneralApiFailure =
    'Uh Oh! Something Went Wrong! Please Try Again.';

final ObfuscatedKey kDefaultGoogleRecaptchaToken =
    const ObfuscatedKey().k.Q.M.S.V.t.P.l.Y.E.C.z.M.n1.I.X.n8.W.i.b.E.g;
