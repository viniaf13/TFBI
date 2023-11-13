import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class AccountInfoFormData {
  const AccountInfoFormData({
    required this.bankAccountName,
    required this.routingNumber,
    required this.bankAccountNumber,
    required this.bankName,
  });

  factory AccountInfoFormData.empty() => const AccountInfoFormData(
        bankAccountName: '',
        routingNumber: '',
        bankAccountNumber: '',
        bankName: '',
      );

  final String bankAccountName;
  final String routingNumber;
  final String bankAccountNumber;
  final String bankName;
}
