import 'package:txfb_insurance_flutter/domain/models/file_a_claim/policy_auto_success.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/policy_homeowner_success.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';

class PolicySuccess {
  PolicySuccess({
    required this.policyType,
    this.policyAutoSuccess,
    this.policyHomeOwnerSuccess,
  });

  final PolicyAutoSuccess? policyAutoSuccess;
  final PolicyHomeownerSuccess? policyHomeOwnerSuccess;
  final PolicyType policyType;
}
