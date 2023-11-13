// coverage:ignore-file

import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

part 'policy_detail.g.dart';

@JsonSerializable()
class PolicyDetail {
  PolicyDetail({
    required this.effectiveDate,
    required this.expirationDate,
    required this.policyBilling,
    required this.policyDescription,
    required this.policyNumber,
    required this.policySubType,
    required this.policyType,
    this.namedInsuredOne,
    this.namedInsuredTwo,
    this.writingCompanyName,
  });
  factory PolicyDetail.fromJson(Map<String, dynamic> json) =>
      _$PolicyDetailFromJson(json);

  @JsonKey(name: 'PolicyNumber')
  final String policyNumber;
  @JsonKey(name: 'PolicyType')
  final String policyType;
  @JsonKey(name: 'PolicySubType')
  final String policySubType;
  @JsonKey(name: 'PolicyDescription')
  final String policyDescription;
  @JsonKey(name: 'EffectiveDate')
  final String effectiveDate;
  @JsonKey(name: 'ExpirationDate')
  final String expirationDate;
  @JsonKey(name: 'NamedInsuredOne')
  final String? namedInsuredOne;
  @JsonKey(name: 'NamedInsuredTwo')
  final String? namedInsuredTwo;
  @JsonKey(name: 'WritingCompanyName')
  final String? writingCompanyName;
  @JsonKey(name: 'PolicyBilling')
  final PolicyBilling policyBilling;

  Map<String, dynamic> toJson() => _$PolicyDetailToJson(this);

  Address? get fullAddress {
    if (this is AutoPolicyDetail) {
      return (this as AutoPolicyDetail).policyAddress;
    }
    if (this is HomeownerPolicyDetail) {
      return (this as HomeownerPolicyDetail).insuredAddress;
    }
    if (this is AgAdvantagePolicyDetail) {
      return (this as AgAdvantagePolicyDetail).insuredAddress;
    }
    return null;
  }
}

@JsonSerializable()
class Address {
  Address(
    this.address1,
    this.address2,
    this.address3,
    this.city,
    this.state,
    this.zipCode,
    this.zipCode4,
    this.zipCode2,
  );
  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  @JsonKey(name: 'Address1')
  final String address1;
  @JsonKey(name: 'Address2')
  final String? address2;
  @JsonKey(name: 'Address3')
  final String? address3;
  @JsonKey(name: 'City')
  final String city;
  @JsonKey(name: 'State')
  final String state;
  @JsonKey(name: 'ZipCode')
  final String zipCode;
  @JsonKey(name: 'ZipCode4')
  final String? zipCode4;
  @JsonKey(name: 'ZipCode2')
  final String? zipCode2;

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  String get cityStateZip => '${city.toTitleCase()}, $state $zipCode';
}

@JsonSerializable()
class PolicyBilling {
  PolicyBilling(
    this.billAccountNumber,
    this.billedPremiumAmount,
    this.billingPlan,
    this.currentAmountDue,
    this.currentPaymentDueDate,
    this.eBillStatus,
    this.pastDueAmount,
    this.paymentHistory,
    this.grossPremiumAmount,
    this.totalDiscounts,
    this.theftFee,
  );
  factory PolicyBilling.fromJson(Map<String, dynamic> json) =>
      _$PolicyBillingFromJson(json);

  @JsonKey(name: 'BillAccountNumber')
  final String billAccountNumber;
  @JsonKey(name: 'BilledPremiumAmount')
  final String billedPremiumAmount;
  @JsonKey(name: 'BillingPlan')
  final String billingPlan;
  @JsonKey(name: 'CurrentAmountDue')
  final String currentAmountDue;
  @JsonKey(name: 'CurrentPaymentDueDate')
  final String currentPaymentDueDate;
  @JsonKey(name: 'EbillStatus')
  final String eBillStatus;
  @JsonKey(name: 'PastDueAmount')
  final String pastDueAmount;
  @JsonKey(name: 'PaymentHistory')
  final List<PaymentHistory>? paymentHistory;
  @JsonKey(name: 'GrossPremiumAmount')
  final String? grossPremiumAmount;
  @JsonKey(name: 'TotalDiscounts')
  final String? totalDiscounts;
  @JsonKey(name: 'TheftFee')
  final String? theftFee;
  Map<String, dynamic> toJson() => _$PolicyBillingToJson(this);

  Map<String, String> get mapPremiumForCurrentPolicy => {
        'Term Premium': grossPremiumAmount.formatCurrency(),
        'Total Discounts': totalDiscounts.formatCurrency(),
        'Billed Premium': billedPremiumAmount.formatCurrency(),
        'Theft fee': theftFee.formatCurrency(),
      };
}
