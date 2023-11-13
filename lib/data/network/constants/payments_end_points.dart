/// kBaseUrl + "Service Base Url" + "Bill Lockup End Point"
/// Example:
/// https://web.txfb-ins.com/services/TFBIC.Services.RESTPayments.Lookup/account-bill/policyholder/$kMemberNumber
library;

/// Services Base URLs
const String kBasePaymentPath = 'services/TFBIC.Services.RESTPayments.Lookup';
// Returns the account bill
const String kAccountBillEndpoint =
    'account-bill/policyholder/{$kMemberNumberPayments}';

/// @Path Constants
const String kMemberNumberPayments = 'MEMBERNUMBERPAYMENTS';
