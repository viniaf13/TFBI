// coverage:ignore-file

import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/autopay_form_state.dart';
import 'package:txfb_insurance_flutter/domain/models/login/tfb_user.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';

part 'autopay_submission_request.g.dart';

@JsonSerializable()
class AutopaySubmissionRequest {
  AutopaySubmissionRequest({
    required this.accountType,
    required this.agentId,
    required this.bankAccountNumber,
    required this.bankName,
    required this.bankRoutingNumber,
    required this.effectiveDate,
    required this.insuredEmailAddress,
    required this.memberNumber,
    required this.paymentDate,
    required this.policyNumber,
    required this.policySubType,
    required this.policyType,
    required this.policyholderName,
    required this.requestType,
  });

  // Used by enroll and update constructors, only difference is requestType
  factory AutopaySubmissionRequest._create(
    PolicySummary policy,
    AutopayFormState formState,
    TfbUser user,
    AutopayRequestType requestType,
  ) =>
      AutopaySubmissionRequest(
        accountType: formState.accountType,
        agentId: policy.agentCode ?? '',
        bankAccountNumber: formState.bankAccountNumber,
        bankName: formState.bankName,
        bankRoutingNumber: formState.bankRoutingNumber,
        effectiveDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        insuredEmailAddress: user.memberEmailAddress!,
        memberNumber: user.members!.first.memberNumber,
        paymentDate: formState.paymentDate,
        policyNumber: policy.policyNumber,
        policySubType: policy.policySubType,
        policyType: policy.policyType.value,
        policyholderName: formState.nameOnBankAccount,
        requestType: requestType,
      );

  factory AutopaySubmissionRequest.enroll(
    PolicySummary policy,
    AutopayFormState formState,
    TfbUser user,
  ) =>
      AutopaySubmissionRequest._create(
        policy,
        formState,
        user,
        AutopayRequestType.enroll,
      );

  factory AutopaySubmissionRequest.update(
    PolicySummary policy,
    AutopayFormState formState,
    TfbUser user,
  ) =>
      AutopaySubmissionRequest._create(
        policy,
        formState,
        user,
        AutopayRequestType.update,
      );

  // This constructor may need to be modified slightly when we get to the actual
  // disenrollment work
  factory AutopaySubmissionRequest.disenroll(
    PolicySummary policy,
    TfbUser user,
  ) =>
      AutopaySubmissionRequest(
        accountType: AutopayAccountType.unknown,
        agentId: '',
        bankAccountNumber: '',
        bankName: '',
        bankRoutingNumber: '',
        effectiveDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        insuredEmailAddress: '',
        memberNumber: user.members!.first.memberNumber,
        paymentDate: 0,
        policyNumber: policy.policyNumber,
        policySubType: policy.policySubType,
        policyType: policy.policyType.value,
        policyholderName: policy.policyInsuredName,
        requestType: AutopayRequestType.disenroll,
      );

  factory AutopaySubmissionRequest.fromJson(Map<String, dynamic> json) =>
      _$AutopaySubmissionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AutopaySubmissionRequestToJson(this);

  @JsonKey(name: 'AccountType')
  final AutopayAccountType accountType;
  @JsonKey(name: 'AgentId')
  final String agentId;
  @JsonKey(name: 'BankAccountNumber')
  final String bankAccountNumber;
  @JsonKey(name: 'BankName')
  final String bankName;
  @JsonKey(name: 'BankRoutingNumber')
  final String bankRoutingNumber;
  @JsonKey(name: 'EffectiveDate')
  final String effectiveDate;
  @JsonKey(name: 'InsuredEmailAddress')
  final String insuredEmailAddress;
  @JsonKey(name: 'MemberNumber')
  final String memberNumber;
  @JsonKey(name: 'PaymentDate')
  final int paymentDate;
  @JsonKey(name: 'PolicyNumber')
  final String policyNumber;
  @JsonKey(name: 'PolicySubType')
  final String policySubType;
  @JsonKey(name: 'PolicyType')
  final String policyType;
  @JsonKey(name: 'PolicyholderName')
  final String policyholderName;
  @JsonKey(name: 'RequestType', unknownEnumValue: AutopayRequestType.unknown)
  final AutopayRequestType requestType;

  @override
  String toString() {
    String returnStr = '';
    returnStr += 'accountType: $accountType\n';
    returnStr += 'agentId: $agentId\n';
    returnStr += 'bankAccountNumber: $bankAccountNumber\n';
    returnStr += 'bankName: $bankName\n';
    returnStr += 'bankRoutingNumber: $bankRoutingNumber\n';
    returnStr += 'effectiveDate: $effectiveDate\n';
    returnStr += 'insuredEmailAddress: $insuredEmailAddress\n';
    returnStr += 'memberNumber: $memberNumber\n';
    returnStr += 'paymentDate: $paymentDate\n';
    returnStr += 'policyNumber: $policyNumber\n';
    returnStr += 'policySubType: $policySubType\n';
    returnStr += 'policyType: $policyType\n';
    returnStr += 'policyholderName: $policyholderName\n';
    returnStr += 'requestType: $requestType\n';
    return returnStr;
  }
}
