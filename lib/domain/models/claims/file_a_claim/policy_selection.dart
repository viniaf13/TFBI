// coverage:ignore-file

import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';

class PolicySelection {
  PolicySelection({
    required this.policyNumber,
    required this.policyType,
    required this.insuredName,
    required this.policySymbol,
  });

  final String policyNumber;
  final PolicyType policyType;
  final String insuredName;
  final String policySymbol;
}
