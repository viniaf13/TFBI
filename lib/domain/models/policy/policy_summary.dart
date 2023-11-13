// coverage:ignore-file
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/constants/tfb_asset_strings.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

part 'policy_summary.g.dart';

enum PolicyStatus {
  active('ACTIVE'),
  inactive('INACTIVE');

  const PolicyStatus(this.value);

  final String value;
}

@JsonEnum(valueField: 'value')
enum PolicyType {
  agAdvantage('AA'),
  homeowners('HT'),
  inlandMarine('PF'),
  lifeAndEndowment('LI'),
  txPersonalAuto('SM'),
  umbrella('UM'),
  unsupportedPolicy('');

  const PolicyType(this.value);

  final String value;

  String name(BuildContext context) {
    switch (this) {
      case agAdvantage:
        return context.getLocalizationOf.agAdvantagePolicyName;
      case homeowners:
        return context.getLocalizationOf.homeownersPolicyName;
      case txPersonalAuto:
        return context.getLocalizationOf.txPersonalAutoPolicyName;
      case _:
        // Unsupported
        return '';
    }
  }

  String policyTypeIcon() {
    switch (this) {
      case PolicyType.homeowners:
        return TfbAssetStrings.homePolicyIcon;
      case PolicyType.txPersonalAuto:
        return TfbAssetStrings.autoPolicyIcon;
      // Add additional policy types as they become available
      default:
        return '';
    }
  }
}

// Duplication of PreNoteSent is intentional
@JsonEnum(valueField: 'value')
enum RecurringStatus {
  active('ACT'),
  deactivated('DAC'),
  preNoteSent('PNE'),
  preNoteSetup('PNS'),
  reactivated('RAC'),
  reactivationReinstate('RAI'),
  reactivationReissue('RAR'),
  preNoteSent2('SNT'),
  notEnrolled('n/a'),
  undefined('undefined');

  const RecurringStatus(this.value);

  final String value;
}

@JsonEnum(valueField: 'value')
enum RecurringFlag {
  enrolled('Y'),
  notEnrolled('N'),
  undefined('undefined');

  const RecurringFlag(this.value);

  final String value;
}

@JsonSerializable()
class PolicySummary {
  PolicySummary({
    required this.policyNumber,
    required this.memberNumber,
    required this.policyType,
    required this.policySubType,
    required this.policySymbol,
    required this.policyDescription,
    required this.policyStatus,
    required this.billingStatus,
    required this.billAccountNumber,
    required this.contractNumber,
    required this.masterAccountNumber,
    required this.policyEffectiveDate,
    required this.policyExpirationDate,
    required this.policyMinimumAmountDue,
    required this.policyMaximumAmountDue,
    required this.policyPastDueAmount,
    required this.policyNSFAmount,
    required this.policyDueDate,
    required this.policyInsuredName,
    required this.paymentRestriction,
    required this.policyHolderUrl,
    required this.policyIDCardFlag,
    required this.roadsideAssistanceCardFlag,
    required this.policyRecurringFlag,
    required this.policyRecurringStatus,
    required this.policyLinkFlag,
    required this.policyPayableFlag,
    required this.policyPremiumFinanceFlag,
    required this.eBillFlag,
    required this.paperlessFlag,
    required this.laurusFlag,
    required this.accountBillEligibleFlag,
    required this.agentCode,
  });

  // JSON conversion methods.
  factory PolicySummary.fromJson(Map<String, dynamic> json) =>
      _$PolicySummaryFromJson(json);

  Map<String, dynamic> toJson() => _$PolicySummaryToJson(this);

  @JsonKey(name: 'PolicyNumber')
  final String policyNumber;
  @JsonKey(name: 'MemberNumber')
  final String memberNumber;
  @JsonKey(name: 'PolicyType', unknownEnumValue: PolicyType.unsupportedPolicy)
  final PolicyType policyType;
  @JsonKey(name: 'PolicySubType')
  final String policySubType;
  @JsonKey(name: 'PolicySymbol')
  final String policySymbol;
  @JsonKey(name: 'PolicyDescription')
  final String policyDescription;
  @JsonKey(name: 'PolicyStatus')
  final String policyStatus;
  @JsonKey(name: 'BillingStatus')
  final String billingStatus;
  @JsonKey(name: 'BillAccountNumber')
  final String billAccountNumber;
  @JsonKey(name: 'ContractNumber')
  final String contractNumber;
  @JsonKey(name: 'MasterAccountNumber')
  final String masterAccountNumber;
  @JsonKey(name: 'PolicyEffectiveDate')
  final String policyEffectiveDate;
  @JsonKey(name: 'PolicyExpirationDate')
  final String policyExpirationDate;
  @JsonKey(name: 'PolicyMinimumAmountDue')
  final String policyMinimumAmountDue;
  @JsonKey(name: 'PolicyMaximumAmountDue')
  final String policyMaximumAmountDue;
  @JsonKey(name: 'PolicyPastDueAmount')
  final String policyPastDueAmount;
  @JsonKey(name: 'PolicyNSFAmount')
  final String policyNSFAmount;
  @JsonKey(name: 'PolicyDueDate')
  final String policyDueDate;
  @JsonKey(name: 'PolicyInsuredName')
  final String policyInsuredName;
  @JsonKey(name: 'PaymentRestriction')
  final String paymentRestriction;
  @JsonKey(name: 'PolicyHolderUrl')
  final String policyHolderUrl;
  @JsonKey(name: 'PolicyIDCardFlag')
  final String policyIDCardFlag;
  @JsonKey(name: 'RoadsideAssistanceCardFlag')
  final String roadsideAssistanceCardFlag;
  @JsonKey(
    name: 'PolicyRecurringFlag',
    unknownEnumValue: RecurringFlag.undefined,
  )
  final RecurringFlag policyRecurringFlag;
  @JsonKey(
    name: 'PolicyRecurringStatus',
    unknownEnumValue: RecurringStatus.undefined,
  )
  final RecurringStatus policyRecurringStatus;
  @JsonKey(name: 'PolicyLinkFlag')
  final String policyLinkFlag;
  @JsonKey(name: 'PolicyPayableFlag')
  final String policyPayableFlag;
  @JsonKey(name: 'PolicyPremiumFinanceFlag')
  final String policyPremiumFinanceFlag;
  @JsonKey(name: 'EBillFlag')
  final String eBillFlag;
  @JsonKey(name: 'PaperlessFlag')
  final String paperlessFlag;
  @JsonKey(name: 'LaurusFlag')
  final String laurusFlag;
  @JsonKey(name: 'AccountBillEligibleFlag')
  final String accountBillEligibleFlag;
  @JsonKey(name: 'AgentCode')
  final String? agentCode;

  // Copy constructor for duplicating Policies objects.
  // NOTE: List copies are only shallow! May need modification.
  PolicySummary copy() {
    return PolicySummary(
      policyNumber: policyNumber,
      memberNumber: memberNumber,
      policyType: policyType,
      policySubType: policySubType,
      policySymbol: policySymbol,
      policyDescription: policyDescription,
      policyStatus: policyStatus,
      billingStatus: billingStatus,
      billAccountNumber: billAccountNumber,
      contractNumber: contractNumber,
      masterAccountNumber: masterAccountNumber,
      policyEffectiveDate: policyEffectiveDate,
      policyExpirationDate: policyExpirationDate,
      policyMinimumAmountDue: policyMinimumAmountDue,
      policyMaximumAmountDue: policyMaximumAmountDue,
      policyPastDueAmount: policyPastDueAmount,
      policyNSFAmount: policyNSFAmount,
      policyDueDate: policyDueDate,
      policyInsuredName: policyInsuredName,
      paymentRestriction: paymentRestriction,
      policyHolderUrl: policyHolderUrl,
      policyIDCardFlag: policyIDCardFlag,
      roadsideAssistanceCardFlag: roadsideAssistanceCardFlag,
      policyRecurringFlag: policyRecurringFlag,
      policyRecurringStatus: policyRecurringStatus,
      policyLinkFlag: policyLinkFlag,
      policyPayableFlag: policyPayableFlag,
      policyPremiumFinanceFlag: policyPremiumFinanceFlag,
      eBillFlag: eBillFlag,
      paperlessFlag: paperlessFlag,
      laurusFlag: laurusFlag,
      accountBillEligibleFlag: accountBillEligibleFlag,
      agentCode: agentCode,
    );
  }

  // toString method for converting Policies} to a string.
  @override
  String toString() {
    String returnStr = '';
    returnStr += 'policyNumber: $policyNumber\n';
    returnStr += 'memberNumber: $memberNumber\n';
    returnStr += 'policyType: $policyType\n';
    returnStr += 'policySubType: $policySubType\n';
    returnStr += 'policySymbol: $policySymbol\n';
    returnStr += 'policyDescription: $policyDescription\n';
    returnStr += 'policyStatus: $policyStatus\n';
    returnStr += 'billingStatus: $billingStatus\n';
    returnStr += 'billAccountNumber: $billAccountNumber\n';
    returnStr += 'contractNumber: $contractNumber\n';
    returnStr += 'masterAccountNumber: $masterAccountNumber\n';
    returnStr += 'policyEffectiveDate: $policyEffectiveDate\n';
    returnStr += 'policyExpirationDate: $policyExpirationDate\n';
    returnStr += 'policyMinimumAmountDue: $policyMinimumAmountDue\n';
    returnStr += 'policyMaximumAmountDue: $policyMaximumAmountDue\n';
    returnStr += 'policyPastDueAmount: $policyPastDueAmount\n';
    returnStr += 'policyNSFAmount: $policyNSFAmount\n';
    returnStr += 'policyDueDate: $policyDueDate\n';
    returnStr += 'policyInsuredName: $policyInsuredName\n';
    returnStr += 'paymentRestriction: $paymentRestriction\n';
    returnStr += 'policyHolderUrl: $policyHolderUrl\n';
    returnStr += 'policyIDCardFlag: $policyIDCardFlag\n';
    returnStr += 'roadsideAssistanceCardFlag: $roadsideAssistanceCardFlag\n';
    returnStr += 'policyRecurringFlag: $policyRecurringFlag\n';
    returnStr += 'policyRecurringStatus: $policyRecurringStatus\n';
    returnStr += 'policyLinkFlag: $policyLinkFlag\n';
    returnStr += 'policyPayableFlag: $policyPayableFlag\n';
    returnStr += 'policyPremiumFinanceFlag: $policyPremiumFinanceFlag\n';
    returnStr += 'eBillFlag: $eBillFlag\n';
    returnStr += 'paperlessFlag: $paperlessFlag\n';
    returnStr += 'laurusFlag: $laurusFlag\n';
    returnStr += 'accountBillEligibleFlag: $accountBillEligibleFlag\n';
    returnStr += 'agentCode: $agentCode\n';
    return returnStr;
  }

  PolicySelection toPolicySelection() => PolicySelection(
        policyNumber: policyNumber,
        policyType: policyType,
        insuredName: policyInsuredName,
        policySymbol: policySymbol,
      );

  bool get paymentIsLate =>
      (policyStatus == PolicyStatus.active.value &&
          laurusFlag == 'Y' &&
          (billingStatus.contains('BAC-9') ||
              billingStatus.contains('BAC-13'))) ||
      (policyStatus != PolicyStatus.active.value &&
          (billingStatus.contains('BAC-9') ||
              billingStatus.contains('BAC-13')) &&
          (double.tryParse(policyMinimumAmountDue) != 0 ||
              double.tryParse(policyMaximumAmountDue) != 0));

  bool get currentAmountDueIsNotZero =>
      double.tryParse(policyMinimumAmountDue) != 0;

  String get currentPaymentDueDateFormat {
    if (policyDueDate.contains('/')) {
      final date = policyDueDate.split('/');
      return '${date[2]}'
          '-${date[0].length == 1 ? '0${date[0]}' : date[0]}-'
          '${date[1].length == 1 ? '0${date[1]}' : date[1]}';
    }
    return policyDueDate;
  }

  String get getDueDateMonthDay {
    final currentDueDate = DateTime.tryParse(currentPaymentDueDateFormat);
    if (currentDueDate != null) {
      return DateFormat('MMMd').format(currentDueDate);
    }
    return '';
  }

  bool get paperlessIsEnabled => paperlessFlag == 'Y';
  bool get ebillIsEnabled => eBillFlag == 'Y';

  bool get isAutopaySupported =>
      policyStatus == PolicyStatus.active.value &&
      policyRecurringFlag == RecurringFlag.enrolled &&
      laurusFlag == 'Y' &&
      (policyRecurringStatus != RecurringStatus.active &&
          policyRecurringStatus != RecurringStatus.reactivated &&
          policyRecurringStatus != RecurringStatus.preNoteSent2 &&
          policyRecurringStatus != RecurringStatus.preNoteSetup &&
          policyRecurringStatus != RecurringStatus.preNoteSent) &&
      masterAccountNumber.isNullOrEmpty;

  bool get isAutoPayEnabled =>
      policyStatus == PolicyStatus.active.value &&
      policyRecurringFlag == RecurringFlag.enrolled &&
      (policyRecurringStatus == RecurringStatus.active ||
          policyRecurringStatus == RecurringStatus.reactivated ||
          policyRecurringStatus == RecurringStatus.preNoteSent2 ||
          policyRecurringStatus == RecurringStatus.preNoteSetup ||
          policyRecurringStatus == RecurringStatus.preNoteSent) &&
      masterAccountNumber.isNullOrEmpty;

  bool get canMakeAPayment =>
      policyPayableFlag == 'Y' &&
      policyPremiumFinanceFlag != 'Y' &&
      (policyRecurringStatus != RecurringStatus.active &&
          policyRecurringStatus != RecurringStatus.reactivated &&
          policyRecurringStatus != RecurringStatus.preNoteSent2 &&
          policyRecurringStatus != RecurringStatus.preNoteSetup &&
          policyRecurringStatus != RecurringStatus.preNoteSent);

  bool get canViewCurrentBill => laurusFlag == 'Y' && masterAccountNumber == '';
}
