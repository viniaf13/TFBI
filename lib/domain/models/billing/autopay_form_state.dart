import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class AutopayFormState {
  AutopayFormState({
    required this.nameOnBankAccount,
    required this.accountType,
    required this.bankRoutingNumber,
    required this.bankAccountNumber,
    required this.bankName,
    required this.paymentDate,
  });

  String nameOnBankAccount;
  AutopayAccountType accountType;
  String bankRoutingNumber;
  String bankAccountNumber;
  String bankName;
  int paymentDate;

  AutopayFormState copyWith({
    String? nameOnBankAccount,
    AutopayAccountType? accountType,
    String? bankRoutingNumber,
    String? bankAccountNumber,
    String? bankName,
    int? paymentDate,
  }) =>
      AutopayFormState(
        nameOnBankAccount: nameOnBankAccount ?? this.nameOnBankAccount,
        accountType: accountType ?? this.accountType,
        bankRoutingNumber: bankRoutingNumber ?? this.bankRoutingNumber,
        bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
        bankName: bankName ?? this.bankName,
        paymentDate: paymentDate ?? this.paymentDate,
      );
}

@JsonEnum(valueField: 'value')
enum AutopayAccountType {
  unknown(''),
  checkings('CH'),
  savings('SA');

  const AutopayAccountType(this.value);

  final String value;
}

@JsonEnum(valueField: 'value')
enum AutopayRequestType {
  unknown(-1),
  enroll(0),
  update(1),
  disenroll(2);

  const AutopayRequestType(this.value);

  final int value;
}
